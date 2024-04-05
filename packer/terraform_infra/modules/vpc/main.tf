resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env}-Terraform_vpc"
  }
}

# task 2 to create public subnet
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.psn1-cidr-block
  availability_zone = var.az
  tags = {
    Name = "${var.env}-public_subnet"
  }
}

# task 3 to create private subnet
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.prn1-cidr-block

  tags = {
    Name = "${var.env}-private_subnet"
  }
}

# task 4 to create IGW
resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.env}-my_igw"
  }
}

# task 6 to create public routing table
resource "aws_route_table" "public_routing_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }

  tags = {
    Name = "${var.env}-public_routing_table"
  }
}

# task 7 To create private routing table
resource "aws_route_table" "private_routing_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }

  tags = {
    Name = "${var.env}-private_routing_table"
  }
}

# task8 To associate public routing table to public subnet

resource "aws_route_table_association" "a_public" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_routing_table.id
}

# task9 To associate private routing table to private subnet

resource "aws_route_table_association" "c_private" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_routing_table.id
}


# Task to create security group
resource "aws_security_group" "Terraform_SG" {
  name        = "Terraform_SG"
  vpc_id      = aws_vpc.my_vpc.id


# here ingress will handle incoming traffic and port 22 is for ssh connection and port 8080 is for webserver
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # it means it allow traffic from anywhere to anywhere
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  # it means it allow traffic from anywhere to anywhere
  }
 # here egress it will handle all outgoing traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # -1 means it will allow all outgoing traffic
    cidr_blocks      = ["0.0.0.0/0"] # it means it allow traffic from anywhere to anywhere
  }

  tags = {
    Name = "${var.env}-Terraform_SG"
  }
}

# create Ec2 instance
resource "aws_instance" "Terraform_Ec2_server" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = "key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet1.id
  vpc_security_group_ids      = [aws_security_group.Terraform_SG.id]
  #availability_zone			      = "ap-south-1b"

  tags = {
    Name = "${var.env}-Terraform_Ec2_server"
  }

#   user_data = <<EOF
#                  #!/bin/bash
#                  sudo yum update -y 
#                  sudo yum install -y docker
#                  sudo systemctl start docker
#                  sudo usermod -aG docker ec2-user
#                  sudo docker run -d -p 8081:80 nginx &
#               EOF

}