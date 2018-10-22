resource "aws_cloudwatch_event_rule" "check_tags" {
  name        = "${terraform.workspace}-${var.project}${var.sub-component}-tagcheck-rule"
  description = "Scheduler to check tags via cron"
  schedule_expression = "${var.schedule_expression}"
  is_enabled = "${var.is_enabled}"
  role_arn = "${aws_iam_role.iam_for_lambda.arn}"
}

resource "aws_cloudwatch_event_target" "tagcheck_lambda" {
  target_id = "${terraform.workspace}-${var.project}${var.sub-component}-tagcheck"
  rule      = "${aws_cloudwatch_event_rule.check_tags.name}"
  arn       = "${aws_lambda_function.tagcheck_lambda.arn}"
  depends_on = [
    "aws_lambda_function.tagcheck_lambda"
  ]
}