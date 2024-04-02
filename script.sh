#!/bin/bash
cd /root/ss/terraform/packer
packer version
packer validate packer.json
if [ $? -eq 0 ]
then
echo "Validation Successful Lets Build The Image"
packer build packer.json 2>&1 | tee output.txt
tail -2 output.txt | head -2 | awk 'match ($0, /ami-.*/) { print substr ($0, RSTART, RLENGTH) } ' > /root/ss/terraform/terraform_infra/ami.txt
AMID=$(cat /root/ss/terraform/terraform_infra/ami.txt)
#echo "variable imagename { default - \"$AMID\"| }" >> variables.tf
#echo \"$AMID\" > /root/ss/terraform/terraform_infra/ami.txt
echo "ami_id = \"$AMID\" " >> /root/ss/terraform/terraform_infra/terraform.tfvars
cd /root/ss/terraform/terraform_infra
terraform init
terraform apply --auto-approve
else
echo "Validation FAILED. Check the CODE"
exit
fi
