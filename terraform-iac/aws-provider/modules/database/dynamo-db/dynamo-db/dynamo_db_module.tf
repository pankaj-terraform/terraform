resource "aws_dynamodb_table" "dynamodb-table" {
  count = (length(var.attribute) > 0) && (length(var.attribute) <= 2) ? 1 : 0
  name  = var.table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key  = var.hash_key
  range_key = length(var.attribute) == 2 ? var.range_key : ""
  dynamic "attribute" {
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
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type
  server_side_encryption {
    enabled = var.encryption
  }
  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }
  tags = var.default_tags
}