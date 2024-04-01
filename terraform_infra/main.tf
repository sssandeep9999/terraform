module "Dev-vpc" {
  source      = "./modules/vpc"
  
  vpc_cidr_block = "10.0.0.0/16"
psn1-cidr-block = "10.0.1.0/24"
prn1-cidr-block = "10.0.2.0/24"
az = "us-east-1a"
env = "Dev"
ami_id = file("${path.module}/ami.txt")
}

# # create infra for production environment

# module "Test-vpc" {
#   source      = "./modules/vpc"
  
#   vpc_cidr_block = "172.16.0.0/16"
# psn1-cidr-block = "172.16.1.0/24"
# prn1-cidr-block = "172.16.2.0/24"
# az = "ap-south-1a"
# env = "Test"

# }

# # create infra for production environment

# module "Prod-vpc" {
#   source      = "./modules/vpc"
  
#   vpc_cidr_block = "192.168.0.0/16"
# psn1-cidr-block = "192.168.1.0/24"
# prn1-cidr-block = "192.168.2.0/24"
# az = "ap-south-1a"
# env = "Prod"

# }