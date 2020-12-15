locals {
   default_tags = {
	 application_id    = var.application_id
	 environment       = var.environment
     data_class        = var.data_class
	 created_by 		= "DEPD"
	 stack_name = "dynao_db Table"
	 termintaion_date = "n/a"
	 
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

  #Local Secondary Index
  local_secondary_index_map = var.local_secondary_index_map

  #Global Secondary Index
  global_secondary_index_map = var.global_secondary_index_map
  
  #Global Tables
  replica_region_name        = var.replica_region_name
  
  #Auto Scaling
  enable_autoscaling =	var.enable_autoscaling
  
  #Tags
  default_tags = local.default_tags
}
