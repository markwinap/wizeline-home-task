variable "app" {
  description = "The name of the app"
  default     = "app"
}

variable "app_port" {
  description = "The port in which the app is listening"
  default     = "8000"
}

variable "asg_id" {
  description = "The ID of the autoscaling group to attach to the load balancer"
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate"
}

variable "environment" {
  description = "The environment, such as development/stage/production"
  default     = "poc"
}

variable "subnet_ids" {
  description = "List of subnet IDs with access to internet gateway"
  type        = "list"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}
