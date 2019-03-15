output "lb_dns_name" {
  value = "${aws_elb.ecs_lb.dns_name}"
}

output "lb_zone_id" {
  value = "${aws_elb.ecs_lb.zone_id}"
}

output "load_balancer_arn" {
  value = "${aws_elb.ecs_lb.arn}"
}