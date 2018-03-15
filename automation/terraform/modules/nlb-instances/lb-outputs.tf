// module tf-alb outputs

output "alb_id" {
  value = "${aws_alb.front_end.id}"
}

output "alb_name" {
  value = "${aws_alb.front_end.name}"
}

output "alb_dns_name" {
  value = "${aws_alb.front_end.dns_name}"
}

output "alb_zone_id" {
  value = "${aws_alb.front_end.zone_id}"
}

output "target_group_arn" {
  value = "${aws_alb_target_group.front_end.arn}"
}

output "alb_listener_id" {
  value = "${aws_alb_listener.front_end_http.id}"
} 