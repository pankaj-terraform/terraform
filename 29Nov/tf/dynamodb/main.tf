locals {
  app_sys_id     = var.app_sys_id
  app_sub_sys_id = var.app_sub_sys_id
  table_name     = length(var.app_sub_sys_id) > 0 ? "${var.app_sys_id}_${var.app_sub_sys_id}_dyn_tab_${var.table_object_name}_${var.default_tags["environment"]}" : "${var.app_sys_id}_dyn_tab_${var.table_object_name}_${var.default_tags["environment"]}"
  lsi_name       = "${var.app_sys_id}_dyn_lsi_${var.lsi_object_name}_${var.default_tags["environment"]}"
  gsi_name       = "${var.app_sys_id}_dyn_gsi_${var.gsi_object_name}_${var.default_tags["environment"]}"
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
  stream_view_type = "KEYS_ONLY"
  server_side_encryption {
    enabled     = "true"
    kms_key_arn = data.aws_kms_alias.kms.arn
  }
  point_in_time_recovery {
    enabled = "true"
  }

  #Local Secondary Index
  dynamic local_secondary_index {
    for_each = var.lsi_enabled ? [1] : []
    content {
      name               = local.lsi_name
      range_key          = var.lsi_range_key
      projection_type    = var.lsi_projection_type
      non_key_attributes = var.lsi_non_key_attributes
    }
  }

  #Global Secondary Index
  dynamic global_secondary_index {
    for_each = var.gsi_enabled ? [1] : []
    content {
      name               = local.gsi_name
      write_capacity     = var.gsi_write_capacity
      read_capacity      = var.gsi_read_capacity
      hash_key           = var.gsi_hash_key
      range_key          = var.gsi_range_key
      projection_type    = var.gsi_projection_type
      non_key_attributes = var.gsi_non_key_attributes
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
  count              = (var.billing_mode == "PROVISIONED") ? 1 : 0
  max_capacity       = 1000
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table[0].name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb-test-table_read_policy" {
  count              = (var.billing_mode == "PROVISIONED") ? 1 : 0
  name               = "dynamodb-read-capacity-utilization-${aws_appautoscaling_target.dynamodb_table_read_target[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_read_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_read_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_read_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }
    target_value = 70
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  count              = (var.billing_mode == "PROVISIONED") ? 1 : 0
  max_capacity       = 1000
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.dynamodb-table[0].name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb-test-table_write_policy" {
  count              = (var.billing_mode == "PROVISIONED") ? 1 : 0
  name               = "dynamodb-write-capacity-utilization-${aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_write_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_write_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_write_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }
    target_value = 70
  }
}