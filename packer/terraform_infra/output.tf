# output "my_instance_id" {
#   value = module.Dev-vpc.instance_id
# }

# output "Ec2_name" {
#     description = "To print Ec2 instance name"
#     value = module.Dev-vpc.instance_tags.Name
# }

# output "public_ip" {
#   description = "List of public IP addresses assigned to the instances, if applicable"
#   value       = module.Dev-vpc.instances.public.ip
# }

output "my_instance_id" {
  value = module.Dev-vpc.instance_id
}

output "my_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.Dev-vpc.public_ip
}