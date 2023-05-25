output "ec2_global_ips" {
  value = [ aws_instance.bastion-host.*.public_ip ]
}

output "bastion-host-security-group" {
  value = aws_security_group.bastion-host-security-group
}
