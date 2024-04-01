#!/bin/bash
packer version
packer validate /packer/packer.json
if [ $? -eq 0 ]
then
echo "Validation Successful Lets Build The Image"
packer build /packer/packer.json 2>&1 | tee output.txt
tail -2 output.txt | head -2 | awk 'match ($0, /ami-.*/) { print substr ($0, RSTART, RLENGTH) } ' > /terraform_infra/ami.txt
AMID=$(cat ami.txt)
echo "variable imagename { default - \"$AMID\"| }" >> variables.tf
terraform init
terraform apply
else
echo "Validation FAILED. Check the CODE"
exit
fi