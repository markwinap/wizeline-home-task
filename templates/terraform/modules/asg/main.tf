data "template_file" "app" {
  # User Data script
  template = "${file("${path.module}/userdata.sh.tpl")}"

  # TODO: add variables to the user data script
  # vars {
  #   example = "${var.example}"
  # }
}

resource "aws_launch_template" "app" {
  name = "${var.app}-${var.environment}"

  key_name      = "${var.key_pair_name}"
  image_id      = "${data.aws_ami.amz_linux_2.id}"
  instance_type = "${var.instance_type}"

  # Root volume
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = "${var.ebs_volume_size}"
      volume_type = "gp2"
    }
  }

  iam_instance_profile {
    name = "${aws_iam_instance_profile.app.name}"
  }

  ebs_optimized          = true
  vpc_security_group_ids = ["${module.sg.this_security_group_id}"]

  # User Data script
  user_data = "${base64encode(data.template_file.app.rendered)}"

  tags = {
    Name        = "${var.app}-${var.environment}"
    environment = "${var.environment}"
    service     = "${var.app}"
    terraform   = "true"
  }
}

resource "aws_autoscaling_group" "app" {
  # Forces a new ASG creation on every Launch Template update
  name = "${var.app}-${var.environment}-asg-${aws_launch_template.app.latest_version}"

  # Required to redeploy without an outage
  lifecycle {
    create_before_destroy = true
  }

  desired_capacity = "${var.asg_min}"
  max_size         = "${var.asg_max}"
  min_size         = "${var.asg_min}"

  vpc_zone_identifier = ["${var.subnet_ids}"]

  launch_template = {
    id      = "${aws_launch_template.app.id}"
    version = "${aws_launch_template.app.latest_version}"
  }

  tags = [
    {
      key = "Name"

      value = "${var.app}-${var.environment}-${aws_launch_template.app.latest_version}"

      propagate_at_launch = "true"
    },
    {
      key = "environment"

      value = "${var.environment}"

      propagate_at_launch = "true"
    },
    {
      key = "service"

      value = "${var.app}"

      propagate_at_launch = "true"
    },
    {
      key = "terraform"

      value = "true"

      propagate_at_launch = "true"
    },
  ]
}
