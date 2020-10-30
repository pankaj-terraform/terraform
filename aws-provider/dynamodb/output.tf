output "dynamo_table_id" {
  value = aws_dynamodb_table.dynamodb-table.*.id
}

output "dynamo_table_arn" {
  value = aws_dynamodb_table.dynamodb-table.*.arn
}

output "dynamo_table_name" {
  value = aws_dynamodb_table.dynamodb-table.*.name
}
