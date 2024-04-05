#!/bin/bash
cd ./packer
packer plugins install github.com/hashicorp/amazon
packer version
packer validate packer.json
if [ $? -eq 0 ]
then
echo "Validation Successful Lets Build The Image"
packer build packer.json 2>&1 | tee output.txt
tail -2 output.txt | head -2 | awk 'match ($0, /ami-.*/) { print substr ($0, RSTART, RLENGTH) } ' > ami.txt
AMID=$(cat ami.txt)
#echo "variable imagename { default - \"$AMID\"| }" >> variables.tf
#echo \"$AMID\" > /root/terraform/terraform_infra/ami.txt
cat ./terraform_infra/variables.txt > ./terraform_infra/terraform.tfvars
echo "ami_id = \"$AMID\" " >> ./terraform_infra/terraform.tfvars
cat ./terraform_infra/terraform.tfvars
cd ./terraform_infra
terraform init
terraform apply --auto-approve packer 2>&1 | tee weboutput.txt
else
echo "Validation FAILED. Check the CODE"
exit
fi
