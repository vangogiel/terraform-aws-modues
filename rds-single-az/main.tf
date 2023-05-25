resource "aws_security_group" "rds_security_group" {
  name          = "rds-security-group"
  vpc_id        = var.vpc_id
  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [ var.additional_db_security_group.id ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_db_subnet_group" "rds_subnet" {
    name        = "rds-subnet-group"
    subnet_ids  = var.private_subnets[*].id
}

resource "aws_db_instance" "rds_instance" {
    depends_on = [ 
        aws_security_group.rds_security_group
    ]
    allocated_storage       = var.db_allocated_storage
    identifier              = "rds-${var.db_engine}"
    engine                  = var.db_engine
    engine_version          = var.db_engine_version
    instance_class          = var.db_instance_class
    db_name                 = "main"
    username                = var.db_username
    password                = var.db_password
    port                    = var.db_port
    skip_final_snapshot     = true
    storage_encrypted       = true
    vpc_security_group_ids  = aws_security_group.rds_security_group[*].id
    db_subnet_group_name    = aws_db_subnet_group.rds_subnet.id

    tags = {
        Name = "rds-instance"
    }
}
