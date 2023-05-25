# Bastion - Multiple Availability Zones

This module is set to deploy an EC2 bastion host to an exsiting set of public subnets.
If the supplied array of subnets includes only one, the host is only going to be deployed to that one availability zone.

The security group is set to allow internet access from anywhere at port 22.
The public key supplied will be used to allow to ssh into that instance.
