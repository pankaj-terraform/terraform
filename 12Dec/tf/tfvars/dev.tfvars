table_object_name = "test"
attribute         = { id = "N", name = "S", subject = "S", stream = "S" , Timestamp = "S", HighWater = "S", subject123 = "S", stream123 = "S" }
hash_key          = "id"
range_key         = "name"
billing_mode      = "PROVISIONED"
read_capacity     = 5
write_capacity    = 5
app_sys_id        = "7892"
app_sub_sys_id    = "12345"
local_secondary_index_map = [
    {
      name               = "TimestampSortIndex"
      range_key          = "Timestamp"
      projection_type    = "ALL"
      non_key_attributes = []
    },
    {
      name               = "HighWaterIndex"
      range_key          = "HighWater"
      projection_type    = "ALL"
      non_key_attributes = []
    }
  ]

global_secondary_index_map = [
    {
      name               = "subjectIndex"
      hash_key           = "subject"
      range_key          = "stream"
      write_capacity     = 5
      read_capacity      = 5
      projection_type    = "ALL"
      non_key_attributes = []
    },
        {
      name               = "subjectIndex123"
      hash_key           = "subject123"
      range_key          = "stream123"
      write_capacity     = 5
      read_capacity      = 5
      projection_type    = "ALL"
      non_key_attributes = []
    }
  ]


enable_autoscaling=true


   application_id    = "12345"
        environment       = "d"
        created_by        = "Ravi"
        date_class        = "yellow"
        termination_date  = "n/a"
        stack_name        = "dynamo_db Table"
