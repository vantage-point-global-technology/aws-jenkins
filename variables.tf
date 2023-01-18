# Set the AWS region that 
# everything will be created in 
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

# Set the CIDR block for the VPC
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Set the name of the 
# Amazon Machine Image (AMI)
variable "ami_name" {
  description = "Name of AMI"
  type        = string
  default     = "amzn2-ami-kernel-5.10-hvm-2.0.20221210.1-x86_64-gp2"
}

# Set the number of subnets
variable "subnet_count" {
  description = "Number of subnets"
  type        = number
  default     = 1
}

# Set the type of EC2 instance
variable "instance_type" {
  description = "Settings for EC2 instances"
  type        = string
  default     = "t2.micro"
}

# Set the number of EC2 instances
variable "instance_count" {
  description = "Settings for EC2 instances"
  type        = number
  default     = 1
}

# Set the Subnet CIDR blocks
variable "subnet_cidr_blocks" {
  description = "Available CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
  ]
}

variable "local_ip" {
  description = "my IP address"
  type = string
  default = "151.237.232.142"
}


