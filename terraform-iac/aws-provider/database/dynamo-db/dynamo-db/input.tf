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
  default     = 1
}
variable "write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field is required"
  type        = number
  default     = 1
}

variable "encryption" {
  description = "Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS owned Customer Master Key if this argument isn't specified."
  type        = bool
  default     = true
}
variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST. Defaults to PROVISIONED."
  type        = string
  default     = "PROVISIONED"
}
variable "stream_enabled" {
  description = " Indicates whether Streams are to be enabled (true) or disabled (false)."
  type        = bool
  default     = true
}
variable "stream_view_type" {
  description = "When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  type        = string
  default     = "KEYS_ONLY"
}
variable "point_in_time_recovery" {
  description = " Point-in-time recovery options."
  type        = bool
  default     = true
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

variable "application_id" {}
variable "environment" {}
variable "created_by" {}

