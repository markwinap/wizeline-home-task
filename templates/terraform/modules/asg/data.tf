# Most recent Amazon Linux 2 AMI
data "aws_ami" "amz_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "name"
    values = ["*x86_64-gp2"]
  }
}
