output "dynamo_table_id" {
  value = module.create_dynamodb_table.dynamo_table_id
}

output "dynamo_table_arn" {
  value = module.create_dynamodb_table.dynamo_table_arn
}

output "dynamo_table_name" {
  value = module.create_dynamodb_table.dynamo_table_name
}