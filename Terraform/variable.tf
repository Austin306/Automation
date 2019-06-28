variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-024a64a6685d05041" # ubuntu 18.04 LTS
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.2.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.2.1.0/24"
}

variable "private_subnet_cidr_1" {
    description = "CIDR for the Private Subnet"
    default = "10.2.2.0/24"
}

variable "private_subnet_cidr_2" {
    description = "CIDR for the Private Subnet"
    default = "10.2.3.0/24"
}
variable "private_subnet_cidr_3" {
    description = "CIDR for the Private Subnet"
    default = "10.2.4.0/24"
}

