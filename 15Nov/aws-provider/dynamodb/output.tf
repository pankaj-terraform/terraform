output "dynamo_table_id" {
  value = aws_dynamodb_table.dynamodb-table.*.id
}

output "dynamo_table_arn" {
  value = aws_dynamodb_table.dynamodb-table.*.arn
}

output "dynamo_table_name" {
  value = aws_dynamodb_table.dynamodb-table.*.name
}

output "dynamo_table_stream_arn" {
  value = aws_dynamodb_table.dynamodb-table.*.stream_arn
}

output "dynamo_table_stream_label" {
  value = aws_dynamodb_table.dynamodb-table.*.stream_label
}
