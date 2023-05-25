variable "vpc_id" {
    type        = string
    description = "Id of the VPC for the host"
}

variable "key_name" {
    type        = string
    default     = "aws"
    description = "Name for the public key"
}

variable "public_key" {
    type        = string
    description = "Public key for bastion host"
}

variable "ami" {
    type        = string
    description = "Amazon Machine Image Id"
    default     = "ami-0582d5cf3037b773a"
}

variable "instance_type" {
    type        = string
    description = "Instance Type for bation host"
    default     = "t4g.small"
}

variable "public_subnets" {
    type        = list
    description = "List of public subnets"
}
