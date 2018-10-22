resource "aws_lambda_function" "tagcheck_lambda" {
  filename         = "${terraform.workspace}-${var.project}${var.sub-component}-tagcheck.zip"
  function_name    = "${terraform.workspace}-${var.project}${var.sub-component}-tagcheck"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "${terraform.workspace}-${var.project}${var.sub-component}-tagcheck.handler"
  //source_code_hash = "${base64sha256(file("${path.module}/files/${terraform.workspace}-${var.project}${var.sub-component}-tagcheck.zip"))}"
  source_code_hash = "${base64sha256(file("${terraform.workspace}-${var.project}${var.sub-component}-tagcheck.zip"))}"
  
  runtime          = "${var.runtime}"
  timeout          = "${var.timeout}"

  tags {
    key    = "tag:Terminate"
    values = "midnight"
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.tagcheck_lambda.function_name}"
  principal      = "events.amazonaws.com"
  source_arn     = "${aws_cloudwatch_event_rule.check_tags.arn}"
  // qualifier      = "${aws_lambda_alias.tagcheck_alias.name}"
}

//resource "aws_lambda_alias" "tagcheck_alias" {
//  name             = "${terraform.workspace}-${var.project}${var.sub-component}-tagcheck-alias"
//  description      = "${terraform.workspace}-${var.project}${var.sub-component}"
//  function_name    = "${aws_lambda_function.tagcheck_lambda.function_name}"
//  function_version = "$LATEST"
//}