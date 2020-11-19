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

  source = "../dynamodb"

  object_name         = var.object_name
  sys_id             = var.sys_id
  app_sub_sys_id     = var.app_sub_sys_id
  attribute          = var.attribute
  billing_mode       = var.billing_mode
  read_capacity      = var.read_capacity
  write_capacity     = var.write_capacity
  hash_key           = var.hash_key
  range_key          = var.range_key
  
  #Tags
  default_tags   = local.default_tags
}
