locals {
    sys_id   = var.sys_id
    app_sub_sys_id      = var.app_sub_sys_id
}
data "aws_kms_alias" "kms"{
  name = "alias/test"  
}

resource "aws_dynamodb_table" "dynamodb-table" {
  count          = (length(var.attribute) > 0) && (length(var.attribute) <= 2) ? 1 : 0
  name           = length(var.app_sub_sys_id) > 0 ? "${var.sys_id}_${var.app_sub_sys_id}_dyn_tab_${var.object_name}_${var.default_tags["environment"]}" : "${var.sys_id}_dyn_tab_${var.object_name}_${var.default_tags["environment"]}"
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
  tags = merge(var.default_tags, 
	map("name", format("%s-dynamo-db", var.default_tags["application_id"])),
	map("sys_id", format("%s-dynamo-db", local.sys_id)),
	map("app_sub_sys_id", format("%s-dynamo-db", local.app_sub_sys_id)))
}
