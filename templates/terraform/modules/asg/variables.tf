variable "app" {
  description = "The name of the app"
  default     = "app"
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment, such as development/stage/production"
  default     = "poc"
}

variable "instance_type" {
  description = "Instance type of the EC2"
  default     = "t3.micro"
}

variable "ebs_volume_size" {
  description = "The disk size of the root volume for the EC2"
  default     = 30
  type        = "number"
}

variable "asg_max" {
  description = "Maximum number of EC2s in the ASG"
  default     = "1"
}

variable "asg_min" {
  description = "Minimum number of EC2s in the ASG"
  default     = "1"
}

variable "key_pair_name" {
  description = "Name of the AWS key pair"
  default     = "cloudops"
}

variable "subnet_ids" {
  description = "List of subnet IDs for ASG"
  type        = "list"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

# TODO: add variables for User Data script
