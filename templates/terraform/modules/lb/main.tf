# Classic Load Balancer
# https://www.terraform.io/docs/providers/aws/r/elb.html
resource "aws_elb" "app" {
  name            = "${var.app}"
  security_groups = ["${aws_security_group.app.id}"]

  # List of subnets with access to an Internet Gateway
  subnets = "${var.subnet_ids}"

  listener {
    instance_port     = "${var.app_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = "${var.app_port}"
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.certificate_arn}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.app_port}/"
    interval            = 30
  }

  tags {
    Name        = "${var.app}-${var.environment}"
    environment = "${var.environment}"
    service     = "${var.app}"
    terraform   = "true"
  }
}

# Attaches ASG to ELB
# https://www.terraform.io/docs/providers/aws/r/autoscaling_attachment.html
resource "aws_autoscaling_attachment" "default" {
  autoscaling_group_name = "${var.asg_id}"
  elb                    = "${aws_elb.app.id}"
}
