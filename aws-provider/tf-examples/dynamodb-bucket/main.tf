provider "aws" {
  region  = "us-east-2"
  version = "= 3.11.0"
}

module "create_dynamodb_table" {

  source = "../../dynamodb"

  table_name                 = "${var.sys_id}_${var.app_sub_sys_id}_dyn_tab_${var.table_name}_${var.environment}"
  attribute                  = var.attribute
  billing_mode               = var.billing_mode
  read_capacity              = var.read_capacity
  write_capacity             = var.write_capacity
  hash_key                   = var.hash_key
  range_key                  = var.range_key
  ttl_enabled                = var.ttl_enabled
  ttl_attribute_name         = var.ttl_attribute_name
  stream_enabled             = var.stream_enabled
  stream_view_type           = var.stream_view_type
  encryption                 = var.encryption
  encryption_kms_key_arn_cmk = var.encryption_kms_key_arn_cmk
  point_in_time_recovery     = var.point_in_time_recovery
  application_id             = var.application_id

  default_tags = merge(local.default_tags, map("name", var.application_id))
}
