data "aws_iam_policy_document" "app" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app" {
  name               = "${var.app}-${var.environment}"
  assume_role_policy = "${data.aws_iam_policy_document.app.json}"

  tags = {
    Name        = "${var.app}-${var.environment}"
    environment = "${var.environment}"
    service     = "${var.app}"
    terraform   = "true"
  }
}

resource "aws_iam_instance_profile" "app" {
  name = "${var.app}-${var.environment}"
  role = "${aws_iam_role.app.name}"
}

# TODO: add ECR permissions
# resource "aws_iam_role_policy" "app" {
#   name = "${var.app}-${var.environment}"
#   role = "${aws_iam_role.app.id}"

#   policy = <<EOF
# {
#   "Statement": [
#     {
#       "Action": [
#         "<service>:<action>"
#       ],
#       "Effect": "Allow",
#       "Resource": [
#         "<resource>"
#       ]
#     }
#   ],
#   "Version": "2012-10-17"
# }
# EOF
# }
