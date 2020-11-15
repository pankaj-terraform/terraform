resource "aws_dynamodb_table" "dynamodb-table" {
  count          = (length(var.attribute) > 0) && (length(var.attribute) <= 2) ? 1 : 0
  name           = length(var.app_sub_sys_id) > 0 ? "${var.sys_id}_${var.app_sub_sys_id}_dyn_tab_${var.table_name}_${var.default_tags["environment"]}" : "${var.sys_id}_dyn_tab_${var.table_name}_${var.default_tags["environment"]}"
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  range_key      = length(var.attribute) == 2 ? var.range_key : ""
  dynamic attribute {
    for_each = var.attribute
    content {
      name = attribute.key
      type = attribute.value
    }
  }
  ttl {
    enabled        = var.ttl_enabled
    attribute_name = var.ttl_attribute_name
  }
  stream_enabled   = "true"
  stream_view_type = var.stream_view_type
  server_side_encryption {
    enabled     = "true"
    kms_key_arn = data.aws_kms_alias.kms.arn
  }
  point_in_time_recovery {
    enabled = "true"
  }
  tags = merge(var.default_tags, map("name", format("%s-dynamo-db", var.default_tags["application_id"])))
}
