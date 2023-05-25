variable "region" {
  type        = string
  description = "AWS region"
} 

variable "environment" {
  type        = string
  description = "Infrastructure Environment"
}

locals {
  azs         = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

variable "public_subnet_cidrs" {
  type        = list
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
 
variable "private_subnet_cidrs" {
  type        = list
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
