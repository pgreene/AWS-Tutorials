resource "aws_cloudwatch_event_rule" "scheduler" {
  name        = "${terraform.workspace}-${var.project}-${var.sub-component}-logincheck-rule"
  description = "Scheduler to trigger lambda function"
  schedule_expression = "${var.schedule_expression}"
  is_enabled = "${var.is_enabled}"
  role_arn = "${aws_iam_role.iam_for_lambda.arn}"
  //depends_on = [
  //  "aws_lambda_function.lambda"
  //]
}

resource "aws_cloudwatch_event_target" "lambda" {
  target_id = "${terraform.workspace}-${var.project}-${var.sub-component}-logincheck"
  rule      = "${aws_cloudwatch_event_rule.scheduler.name}"
  arn       = "${aws_lambda_function.lambda.arn}"
  //arn       = "${aws_lambda_function.${terraform.workspace}-${var.project}-${var.sub-component}-logincheck.arn}"
  //role_arn  = "${aws_iam_role.iam_for_lambda.arn}"
  //run_command_targets {
    //key    = "tag:Terminate"
    //values = ["midnight"]
  //}
  depends_on = [
    "aws_lambda_function.lambda"
  ]
}