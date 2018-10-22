output "cloudwatch_event_rule_name" {
    value = "${aws_cloudwatch_event_rule.check_tags.name}"
}

output "cloudwatch_event_target_id" {
  value = "${aws_cloudwatch_event_target.tagcheck_lambda.target_id}"
}