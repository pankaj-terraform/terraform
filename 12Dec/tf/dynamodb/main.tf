locals {
  app_sys_id     = var.app_sys_id
  app_sub_sys_id = var.app_sub_sys_id
  table_name     = length(var.app_sub_sys_id) > 0 ? "${var.app_sys_id}_${var.app_sub_sys_id}_dyn_tab_${var.table_object_name}_${var.default_tags["environment"]}" : "${var.app_sys_id}_dyn_tab_${var.table_object_name}_${var.default_tags["environment"]}"
  local_secondary_index_name_list = [
		for lsi in  var.local_secondary_index_map:
            join("",[var.app_sys_id,"_dyn_lsi_",lsi.name,"_",var.default_tags["environment"]])
  ]
  global_secondary_index_name_list = [
		for gsi in  var.global_secondary_index_map:
            join("",[var.app_sys_id,"_dyn_gsi_",gsi.name,"_",var.default_tags["environment"]])
  ]

}

data "aws_kms_alias" "kms" {
  name = "alias/kms-ue2-np-tempest-ms-devops"
}

resource "aws_dynamodb_table" "dynamodb-table" {
  count          = (length(var.attribute) > 0) ? 1 : 0
  name           = local.table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = length(var.attribute) >= 2 ? var.range_key : ""
  dynamic attribute {
    for_each = var.attribute
    content {
      name = attribute.key
      type = attribute.value
    }
  }
  ttl {
    enabled        = "true"
    attribute_name = var.hash_key
  }
  stream_enabled   = "true"
  stream_view_type = "NEW_AND_OLD_IMAGES"

server_side_encryption {
    enabled     = "true"
    kms_key_arn = data.aws_kms_alias.kms.arn
  }
  point_in_time_recovery {
    enabled = "true"
  }

  #Local Secondary Index
  dynamic local_secondary_index {
    for_each = var.local_secondary_index_map
    content {
      name               = local.local_secondary_index_name_list[local_secondary_index.key]
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = local_secondary_index.value.non_key_attributes
    }
  }

  #Global Secondary Index
  dynamic global_secondary_index {
    for_each = var.global_secondary_index_map
    content {
      name               = local.global_secondary_index_name_list[global_secondary_index.key]
      write_capacity     = global_secondary_index.value.write_capacity
      read_capacity      = global_secondary_index.value.read_capacity
      hash_key           = global_secondary_index.value.hash_key
      range_key          = global_secondary_index.value.range_key
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = global_secondary_index.value.non_key_attributes
    }
  }

  # Global Tables
  dynamic replica {
    for_each = var.replica_region_name
    content {
      region_name = replica.value
    }
  }
  tags = merge(var.default_tags, map("name", format("%s", local.table_name)))

}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? 1 : 0
  max_capacity       = 1000
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table[0].name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? 1 : 0
  name               = "DynamoDBReadCapacityUtilization:${join("",aws_appautoscaling_target.dynamodb_table_read_target.*.resource_id)}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = join("",aws_appautoscaling_target.dynamodb_table_read_target.*.resource_id)
  scalable_dimension = join("",aws_appautoscaling_target.dynamodb_table_read_target.*.scalable_dimension)
  service_namespace  = join("",aws_appautoscaling_target.dynamodb_table_read_target.*.service_namespace)

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    target_value = 70
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? 1 : 0
  max_capacity       = 1000
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table[0].name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? 1 : 0
  name               = "DynamoDBWriteCapacityUtilization:${join("",aws_appautoscaling_target.dynamodb_table_write_target.*.resource_id)}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = join("",aws_appautoscaling_target.dynamodb_table_write_target.*.resource_id)
  scalable_dimension = join("",aws_appautoscaling_target.dynamodb_table_write_target.*.scalable_dimension)
  service_namespace  = join("",aws_appautoscaling_target.dynamodb_table_write_target.*.service_namespace)

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }
    target_value = 70
  }
}

resource "aws_appautoscaling_target" "dynamodb_index_read_target" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? length(local.global_secondary_index_name_list) : 0
  max_capacity       = 1000
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table[0].name}/index/${element(local.global_secondary_index_name_list,count.index)}"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
  
}

resource "aws_appautoscaling_policy" "dynamodb_index_read_policy" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? length(local.global_secondary_index_name_list) : 0
  name               = "DynamoDBReadCapacityUtilization:${element(aws_appautoscaling_target.dynamodb_index_read_target.*.resource_id,count.index)}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_index_read_target.*.resource_id[count.index]
  scalable_dimension = aws_appautoscaling_target.dynamodb_index_read_target.*.scalable_dimension[count.index]
  service_namespace  = aws_appautoscaling_target.dynamodb_index_read_target.*.service_namespace[count.index]

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    target_value = 70
  }
}

resource "aws_appautoscaling_target" "dynamodb_index_write_target" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? length(local.global_secondary_index_name_list) : 0
  max_capacity       = 1000
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table[0].name}/index/${element(local.global_secondary_index_name_list,count.index)}"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_index_write_policy" {
  count              = (var.billing_mode == "PROVISIONED" && var.enable_autoscaling) ? length(local.global_secondary_index_name_list) : 0
  name               = "DynamoDBWriteCapacityUtilization:${element(aws_appautoscaling_target.dynamodb_index_write_target.*.resource_id,count.index)}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_index_write_target.*.resource_id[count.index]
  scalable_dimension = aws_appautoscaling_target.dynamodb_index_write_target.*.scalable_dimension[count.index]
  service_namespace  = aws_appautoscaling_target.dynamodb_index_write_target.*.service_namespace[count.index]

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }
    target_value = 70
  }
}
