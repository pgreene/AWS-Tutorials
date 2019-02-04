output "cloudwatch_event_rule_name" {
    value = "${aws_cloudwatch_event_rule.scheduler.name}"
}

output "cloudwatch_event_target_id" {
  value = "${aws_cloudwatch_event_target.lambda.target_id}"
}