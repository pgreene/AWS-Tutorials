output "lambda_function_name" {
    value = "${aws_lambda_function.tagcheck_lambda.function_name}"
}

output "lambda_arn" {
  value = "${aws_lambda_permission.allow_cloudwatch.source_arn}"
}