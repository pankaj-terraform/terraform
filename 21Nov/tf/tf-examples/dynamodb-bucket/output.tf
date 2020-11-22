output "dynamo_table_id" {
  value = module.create_dynamodb_table.dynamo_table_id
}

output "dynamo_table_arn" {
  value = module.create_dynamodb_table.dynamo_table_arn
}

output "dynamo_table_name" {
  value = module.create_dynamodb_table.dynamo_table_name
}

output "dynamo_table_stream_arn" {
  value = module.create_dynamodb_table.dynamo_table_stream_arn
}

output "dynamo_table_stream_label" {
  value = module.create_dynamodb_table.dynamo_table_stream_label
}