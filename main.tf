provider "aws" {
  region = "us-east-1"
  access_key = "AKIA5EN3UA4ANEXZIG4V"
  secret_key = "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"
}
variable "MYVPC_CIDR" {}
variable "MYSUBNET_CIDR" {}
variable "MYZONE" {}
variable "route_cidr" {}
variable "from_port" {}
variable "to_port" {}
variable "protocol" {}
variable "cidr_for_Security" {}
variable "ami" {}
variable "type" {}
variable "security_key" {}
variable "public_ip" {}
resource "aws_vpc" "MY_VPC" {
  cidr_block = var.MYVPC_CIDR
  tags = {
    Name = "MY_VPC"
  }
}
resource "aws_subnet" "my_SUBNET" {
  cidr_block = var.MYSUBNET_CIDR
  availability_zone = var.MYZONE
  vpc_id = aws_vpc.MY_VPC.id
  tags = {
    Name = "MY_SUBNET"
  }
}
resource "aws_internet_gateway" "MY_IGW" {
  vpc_id = aws_vpc.MY_VPC.id
  tags = {
    Name = "MY_IGW"
  }
}
resource "aws_route_table" "MY_ROUTE" {
  vpc_id = aws_vpc.MY_VPC.id
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.MY_IGW.id
  }
  tags = {
    Name = "MY_ROUTE_TABLE"
  }
}
resource "aws_route_table_association" "MY_ASSPCIATION" {
  route_table_id = aws_route_table.MY_ROUTE.id
  subnet_id = aws_subnet.my_SUBNET.id
}
resource "aws_security_group" "MY_SG" {
  name = "MY_SG"
  vpc_id = aws_vpc.MY_VPC.id
  ingress {
    from_port = var.from_port
    protocol = var.protocol
    to_port = var.to_port
    cidr_blocks = [var.cidr_for_Security]
  }
  egress {
    from_port = var.from_port
    protocol = var.protocol
    to_port = var.to_port
    cidr_blocks = [var.cidr_for_Security]
  }
  tags = {
    Name = "mysecurity"
  }
}
resource "aws_instance" "MY_INSTANCE" {
  ami = var.ami
  instance_type = var.type
  subnet_id = aws_subnet.my_SUBNET.id
  availability_zone = var.MYZONE
  vpc_security_group_ids = [aws_security_group.MY_SG.id]
  key_name = var.security_key
  associate_public_ip_address = var.public_ip
  tags = {
    Name = "intel1"
  }
}
