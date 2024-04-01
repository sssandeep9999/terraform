output "Ec2_name" {
    description = "To print Ec2 instance id"
    #value = ["${module.Dev-vpc.aws_instance.Terraform_Ec2_server.tags.name}"]
    value = ["${module.Dev-vpc.Ec2_name}"]
}

# output "Dev_vpc_name" {
#     description = "To print Ec2 instance id"
#     #value = ["${module.Dev-vpc.aws_instance.Terraform_Ec2_server.tags.name}"]
#     value = ["${module.Dev-vpc.name}"]
# }