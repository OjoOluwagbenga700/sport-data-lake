output "sport_lambda_invoke_arn" {
  value = aws_lambda_function.sport_lambda_function.invoke_arn
}

output "sport_lambda_function_name" {
  value = aws_lambda_function.sport_lambda_function.function_name
}