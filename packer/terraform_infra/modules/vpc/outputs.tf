
output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "publicsubnet_id" {
    value = aws_subnet.public_subnet1.id
}

output "privatesubnet_id" {
    value = aws_subnet.private_subnet1.id
}

output "publicroutingtable_id" {
    value = aws_route_table.public_routing_table.id
}

output "privateroutingtable_id" {
    value = aws_route_table.private_routing_table.id
}

output "Igw_id" {
    value = aws_internet_gateway.my_gw.id
}

output "securitygroup_id" {
    value = aws_security_group.Terraform_SG.id
}

output "instance_id" {
    description = "To print Ec2 instance id"
    value = aws_instance.Terraform_Ec2_server.id
}


output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.Terraform_Ec2_server.public_ip
}

