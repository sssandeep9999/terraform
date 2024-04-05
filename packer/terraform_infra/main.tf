module "Dev-vpc" {
  source      = "./modules/vpc"
  
  vpc_cidr_block = var.vpc_cidr_block
psn1-cidr-block = var.psn1-cidr-block
prn1-cidr-block = var.prn1-cidr-block
az = var.az
env = var.env
#ami_id = file("${path.module}/ami.txt")
ami_id = var.ami_id
}
