output "my_instance_id" {
  value = module.Dev-vpc.instance_id
}

output "my_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.Dev-vpc.public_ip
}