variable "table_name" {
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

variable "stream_view_type" {
  description = "When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  type        = string
  default     = "KEYS_ONLY"
}

variable "ttl_enabled" {
  description = "Indicates whether ttl is enabled (true) or disabled (false)."
  type        = bool
  default     = false
}
variable "ttl_attribute_name" {
  description = "The name of the table attribute to store the TTL timestamp in."
  type        = string
  default     = ""
}
variable "default_tags" {
  description = "Map of Default tags"
  type        = map(string)
  default     = {}
}

## Tags ##

variable "application_id" {
  description = "Application ID."
  type        = string
}
variable "environment" {
  description = "Environment."
  type        = string
}
variable "created_by" {
  description = "Created By."
  type        = string
}
variable "stack_name" {
  description = "Stack Name."
  type        = string
}
variable "termination_date" {
  description = "Termination Date."
  type        = string
}
variable "date_class" {
  description = "Date Class."
  type        = string
}
variable "sys_id" {
  description = "System ID."
  type        = string
}
variable "app_sub_sys_id" {
  description = "Application Sub System ID."
  type        = string
}
