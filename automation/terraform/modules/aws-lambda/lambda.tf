resource "aws_lambda_function" "lambda" {
  filename         = "${terraform.workspace}-${var.project}-${var.sub-component}-logincheck.zip"
  function_name    = "${terraform.workspace}-${var.project}-${var.sub-component}-logincheck"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "${terraform.workspace}-${var.project}-${var.sub-component}-logincheck.lambda_handler"
  # handler         = "index.lambda_handler"
  //source_code_hash = "${base64sha256(file("${path.module}/files/${terraform.workspace}-${var.project}-${var.sub-component}-logincheck.zip"))}"
  source_code_hash = "${base64sha256(file("${terraform.workspace}-${var.project}-${var.sub-component}-logincheck.zip"))}"
  
  runtime          = "${var.runtime}"
  timeout          = "${var.timeout}"
  
  vpc_config {
       subnet_ids = ["${var.subnet_ids}"]
       security_group_ids = ["${var.security_group_ids}"]
   }

  tags = {
    Name        = "${var.project}-${var.env}-${var.sub-component}-logincheck"
    Project     = "${var.project}"
    Environment = "${var.env}"
    CostCenter  = "${var.costcenter}"
    Owner       = "${var.owner}"
    Automation  = "Terraform"
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.lambda.function_name}"
  principal      = "events.amazonaws.com"
  source_arn     = "${aws_cloudwatch_event_rule.scheduler.arn}"
  // qualifier      = "${aws_lambda_alias.logincheck_alias.name}"
}

//resource "aws_lambda_alias" "logincheck_alias" {
//  name             = "${terraform.workspace}-${var.project}-${var.sub-component}-logincheck-alias"
//  description      = "${terraform.workspace}-${var.project}-${var.sub-component}"
//  function_name    = "${aws_lambda_function.lambda.function_name}"
//  function_version = "$LATEST"
//}