table_object_name = "test"
attribute         = { id = "N", name = "S" }
hash_key          = "id"
range_key         = "name"
billing_mode      = "PROVISIONED"
read_capacity     = 5
write_capacity    = 5
app_sys_id        = "789"
app_sub_sys_id    = "12345"
lsi_enabled       = false
gsi_enabled       = false
default_tags = {
    application_id    = "12345"
	environment       = "d"
	created_by        = "Ravi"
	date_class        = "yellow"
	termination_date  = "n/a"
	stack_name        = "dynamo_db Table"
}
