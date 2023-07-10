variable "region" {
    default = "ap-south-1"
  }
variable "os-name" {
    default = "ami-0d13e3e640877b0b9"
     }
variable "key" {
        default = "aws"  
     }
variable "instance-type" {
    default = "t2.small"
     }
variable "vpc-cidr" {
    default = "10.10.0.0/16"
  }
variable "subnet1-cidr" {
    default = "10.10.1.0/24"
  }
variable "subnet-az"{
    default = "ap-south-1a"
}         