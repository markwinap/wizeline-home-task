# Creates VPC resources on AWS
# https://github.com/terraform-aws-modules/terraform-aws-vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.app}-${var.environment}"
  cidr = "${var.vpc_cidr}"

  # Creates subnets in only two availability zones
  azs = [
    "${data.aws_availability_zones.azs.names[0]}",
    "${data.aws_availability_zones.azs.names[1]}"
  ]

  enable_dhcp_options = true

  # Uncomment to add private subnets
  # private_subnets     = "${var.private_subnets}"
  # private_subnet_tags = {
  #   Name = "${var.app}-${var.environment}-private"
  #   type = "private"
  # }

  # Uncomment to add private subnets access to the internet
  # enable_nat_gateway = true

  public_subnets = "${var.public_subnets}"
  public_subnet_tags = {
    Name = "${var.app}-${var.environment}-public"
    type = "public"
  }

  tags = {
    Name        = "${var.app}-${var.environment}"
    environment = "${var.environment}"
    service     = "network"
    terraform   = "true"
  }
}
