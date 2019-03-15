variable "app" {
  description = "The name of the app"
  default     = "network"
}

variable "environment" {
  description = "The environment, such as development/stage/production"
  default     = "poc"
}

# http://www.davidc.net/sites/default/subnets/subnets.html
variable "vpc_cidr" {
  description = "The CIDR range to use in the VPC"
  default     = "10.0.1.0/24"
}

variable "public_subnets" {
  description = "The CIDR ranges to use in the public subnets"
  default     = ["10.0.1.0/25", "10.0.1.128/25"]
  type        = "list"
}

# variable "private_subnets" {
#   description = "The CIDR ranges to use in the private subnets"
#   default     = ["",""]
#   type        = "list"
# }
