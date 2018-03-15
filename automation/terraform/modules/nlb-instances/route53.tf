// Route53
resource "aws_route53_record" "public" {
  zone_id = "${var.public_zone_id}"
  name = "${var.project_name}-${data.aws_region.current.name}-${var.tr_env}"
  type = "A"

  alias {
    name                   = "${aws_alb.front_end.dns_name}"
    zone_id                = "${aws_alb.front_end.zone_id}"
    evaluate_target_health = true
  }

  depends_on = ["aws_alb.front_end"]
}

// Route53
// resource "aws_route53_record" "vpc" {
//   zone_id = "${var.zone_id}"
//   name = "${var.project_name}-${var.tr_region}"
//   type = "A"
//   alias {
//     name = "${aws_alb.front_end.dns_name}"
//     zone_id = "${aws_alb.front_end.zone_id}"
//     evaluate_target_health = true
//   }
//   depends_on = ["aws_alb.front_end"]
// }
