provider "aws" {
  region  = "us-east-2"
  version = "= 3.11.0"
}

module "create_dynamodb_table" {

  source = "../dynamodb"

  table_name         = var.table_name
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
