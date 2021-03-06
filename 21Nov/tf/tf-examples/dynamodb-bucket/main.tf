locals {
  default_tags = {
    application_id   = var.application_id
    environment      = var.environment
    created_by       = var.created_by
    stack_name       = var.stack_name
    termination_date = var.termination_date
    date_class       = var.date_class
  }
}

module "create_dynamodb_table" {

  source = "../../dynamodb"

  table_object_name = var.table_object_name
  app_sys_id        = var.app_sys_id
  app_sub_sys_id    = var.app_sub_sys_id
  attribute         = var.attribute
  billing_mode      = var.billing_mode
  read_capacity     = var.read_capacity
  write_capacity    = var.write_capacity
  hash_key          = var.hash_key
  range_key         = var.range_key

  #LSI
  lsi_enabled            = var.lsi_enabled
  lsi_object_name        = var.lsi_object_name
  lsi_range_key          = var.lsi_range_key
  lsi_projection_type    = var.lsi_projection_type
  lsi_non_key_attributes = var.lsi_non_key_attributes

  #Tags
  default_tags = local.default_tags
}
