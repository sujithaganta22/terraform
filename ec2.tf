provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "demo-server" {
    ami = "ami-0d13e3e640877b0b9"
    key_name = "aws"
    instance_type = "t2.small"
    subnet_id = aws_subnet.demo-subnet.id
    vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]
}
//create vpc
resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.10.0.0/16"
}
//create subnet
resource "aws_subnet" "demo-subnet" {
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = "10.10.1.0/24"
    availability_zone = "ap-south-1a"
   tags = {
    name = "demo-subnet"
   } 
}
//create internetgateway(igw)
resource "aws_internet_gateway" "demo-igw"{
    vpc_id = aws_vpc.demo-vpc.id
    tags = {
        name = "demo-igw"
    }
}
//create route table
resource "aws_route_table" "demo-rt" {
    vpc_id = aws_vpc.demo-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }
    tags = {
      name = "demo-rt"
    }
}
//associate subnet  with route table 
resource "aws_route_table_association" "demo-rt-association"{
    subnet_id = aws_subnet.demo-subnet.id
    route_table_id = aws_route_table.demo-rt.id
}
//create security group 
resource "aws_security_group" "demo-vpc-sg"{
    name = "demo-vpc-sg"
    vpc_id = aws_vpc.demo-vpc.id
   ingress {
    from_port =  22
    to_port =  22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
   }
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
   }
   tags = {
    name = " allow-tls"
   } 
}