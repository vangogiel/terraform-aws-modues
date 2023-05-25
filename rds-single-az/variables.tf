variable "vpc_id" {
  type        = string
  description = "Id of the VPC for the host"
}

variable "additional_db_security_group" {
  type        = object({
    id: string
  })
  description = "Additional security for db security groups"
}

variable "private_subnets" {
  type        = list
  description = "List of private subnets"
}

variable "db_username" {
  type          = string
  description   = "Username for the db instance"
}

variable "db_password" {
  type          = string
  description   = "Password for the db instance"
}

variable "db_port" {
  type          = string
  description   = "Port for the db instance"
}

variable "db_engine" {
  type          = string
  description   = "Database engine type as per AWS RDS availability"
}

variable "db_engine_version" {
  type          = string
  description   = "Database engine version as per AWS RDS availability"
}

variable "db_instance_class" {
  type          = string
  description   = "Database instance type"
}

variable "db_allocated_storage" {
  type          = string
  description   = "Database allocated storage"
}
