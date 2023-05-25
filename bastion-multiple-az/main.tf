resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "bastion-host-security-group" {
  description   = "Allow ssh access to bastion host"
  name          = "bastion-host-security-group"
  vpc_id        = var.vpc_id

  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow output from Bastion Host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-host-security-group"
  }
}

resource "aws_instance" "bastion-host" {
    count                   = length(var.public_subnets)
    ami                     = var.ami
    instance_type           = var.instance_type
    subnet_id               = element(var.public_subnets[*].id, count.index)
    key_name                = aws_key_pair.deployer.key_name
    vpc_security_group_ids  = [ aws_security_group.bastion-host-security-group.id ]
    tags = {
        Name = "bastion-host"
    }
}
