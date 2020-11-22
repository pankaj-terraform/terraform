variable "object_name" {
  description = "The name of the table, this needs to be unique within a region."
  type        = string
}

variable "attribute" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute. type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data"
  type        = map(string)
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
}

## Local Secondary Index ##

variable "LSI_enabled" {
  description = "Create Local Secondary Index."
  type        = bool
  default     = false
}

variable "LSI_object_name" {
  description = "The object name of the local secondary index."
  type        = string
  default     = ""
}

variable "LSI_range_key" {
  description = "The name of the range key; must be defined."
  type        = string
  default     = ""
}

variable "LSI_projection_type" {
  description = "One of ALL, INCLUDE or KEYS_ONLY where ALL projects every attribute into the index, KEYS_ONLY projects just the hash and range key into the index, and INCLUDE projects only the keys specified in the non_key_attributes parameter."
  type        = string
  default     = "KEYS_ONLY"
}

variable "LSI_non_key_attributes" {
  description = "Only required with INCLUDE as a projection type; a list of attributes to project into the index. These do not need to be defined as attributes on the table."
  type        = list(string)
  default     = []
}

variable "app_sys_id" {
  description = "Application System ID."
  type        = string
}

variable "app_sub_sys_id" {
  description = "Application Sub System ID."
  type        = string
}

variable "default_tags" {
  description = "Map of Default tags"
  type        = map(string)
}

