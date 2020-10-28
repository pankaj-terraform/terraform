  region  = "us-east-2"
  version = "= 3.7.0"
}

module "create_dynamodb_table" {

  source = "../../../modules/database/dynamo-db/dynamo-db"

  table_name             = "${var.table_name}_${var.environment}"
  attribute              = var.attribute
  billing_mode           = var.billing_mode
  read_capacity          = var.read_capacity
  write_capacity         = var.write_capacity
  hash_key               = var.hash_key
  range_key              = var.range_key
  ttl_enabled            = var.ttl_enabled
  ttl_attribute_name     = var.ttl_attribute_name
  stream_enabled         = var.stream_enabled
  stream_view_type       = var.stream_view_type
  encryption             = var.encryption
  point_in_time_recovery = var.point_in_time_recovery
  application_id         = var.application_id

  default_tags = merge(local.default_tags, map("encryption", var.encryption))
}
