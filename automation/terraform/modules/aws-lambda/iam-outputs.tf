output "iam_role_name" {
    value = "${aws_iam_role.iam_for_lambda.name}"
}

output "iam_policy_name" {
  value = "${aws_iam_policy.lambda_policy.name}"
}