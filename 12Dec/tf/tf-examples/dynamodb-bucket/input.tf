variable "table_object_name" {
  description = "The name of the table, this needs to be unique within a region."
  type        = string
}

variable "attribute" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute. type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data"
  type        = map(string)
  default     = {}
}
variable "hash_key" {
  description = "The attribute to use as the hash (partition) key. Must also be defined as an attribute."
  type        = string
}
variable "range_key" {
  description = "The attribute to use as the range (sort) key. Must also be defined as an attribute."
  type        = string
}

variable "read_capacity" {
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
  type        = number
}
variable "write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field is required"
  type        = number
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST. Defaults to PROVISIONED."
  type        = string
  default     = "PROVISIONED"
}

## Local Secondary Index ##

variable "local_secondary_index_map" {
  description = "Local Secondary Index Map."
  type = list(object({
   name               = string
   range_key          = string
   projection_type    = string
   non_key_attributes = list(string)        
  }))
  default     = []
}


## Global Secondary Index ##

variable "global_secondary_index_map" {
  description = "Global Secondary Index Map."
  type = list(object({
   name        	 = string
  write_capacity         = string
  read_capacity          = string
  hash_key               = string
  range_key              = string
  projection_type        = string
   non_key_attributes = list(string)        
  }))
  default     = []
}

## Global Tables ##

variable "replica_region_name" {
  description = "Region name of the replica."
  type        = list(string)
  default     = []
}

## Auto Scaling ##

variable "enable_autoscaling" {
  description = "Enable Auto Scaling for Table and Indexs."
  type        = bool
  default     = false
}

variable "application_id" {
  description = "Application ID."
  type        = string
}
variable "environment" {
  description = "Environment."
  type        = string
}
variable "data_class" {
  description = "Date Class."
  type        = string
}
variable "app_sys_id" {
  description = "Application System ID."
  type        = string
}
variable "app_sub_sys_id" {
  description = "Application Sub System ID."
  type        = string
}


