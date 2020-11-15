variable "table_name" {}
variable "sys_id" {}
variable "app_sub_sys_id" {}
variable "attribute" { type = map(string) }
variable "read_capacity" { type = number }
variable "write_capacity" { type = number }
variable "hash_key" {}
variable "range_key" {}
variable "billing_mode" {}
variable "stream_view_type" {}
variable "ttl_enabled" { type = bool }
variable "ttl_attribute_name" {}
variable "application_id" {}
variable "default_tags" { type = map(string) }

