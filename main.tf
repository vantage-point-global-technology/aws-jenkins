# Create a data object that contains
# all availability zones in the 
# region with a state of "available"
data "aws_availability_zones" "available" {
  state = "available"
}

# Create a data object that contains
# ifconfig dataand your IP adress
data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

# Set a local variable
locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.response_body)
}

# Create a data object that contains 
# the latest amazon linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name]
  }

  owners = ["amazon"]
}

# Create a VPC named "jenkins_vpc"
resource "aws_vpc" "jenkins_vpc" {
  # Set the VPC CIDR block
  cidr_block = var.vpc_cidr_block
  # Enable DNS hostnames for the VPC
  enable_dns_hostnames = true

  # Tag the VPC with identifiers
  tags = {
    Name  = "jenkins_vpc"
    Class = "jenkins"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "jenkins_igw" {
  # Attach the Internet Gateway to the VPC
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name  = "jenkins_internet_gateway"
    Class = "jenkins"
  }
}

# Create a group of subnets based on the subnet_count
resource "aws_subnet" "jenkins_subnet" {
  # Set the number of subnets to create
  count = var.subnet_count

  # Attach the subnet group to the VPC
  vpc_id = aws_vpc.jenkins_vpc.id

  # Set the CIDR block from the list of subnet_cidr_blocks
  # where the block index is equal to the count 
  cidr_block = var.subnet_cidr_blocks[count.index]

  # Set the availability zone from the available availability zones
  #  where the available availaibility zones index is equa to the count
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name  = "jenkins_subnet_${count.index}"
    Class = "jenkins"
  }
}

# Create a route table 
resource "aws_route_table" "jenkins_route_table" {
  # Attach the route table to the VPC
  vpc_id = aws_vpc.jenkins_vpc.id

  # Set a route with a destination for access 
  # to from the internet and target the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_igw.id
  }

  tags = {
    Name  = "jenkins_route_table"
    Class = "jenkins"
  }
}

# Create a route table association 
resource "aws_route_table_association" "jenkins_route_table_assoc" {
  # Set the number of subnets to associate with the route table
  count = var.subnet_count

  # Attach the route table
  route_table_id = aws_route_table.jenkins_route_table.id

  # Attach the subnet
  subnet_id = aws_subnet.jenkins_subnet[count.index].id
}

# Create a security group for the EC2 instance
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Security group for web traffic"

  # Attach it to the VPC
  vpc_id = aws_vpc.jenkins_vpc.id

  # Make the EC2 instance accessible over SSH
  # only from your IP address
  ingress {
    description = "Allow SSH from my computer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.ifconfig_co_json.ip}/32"]
  }

  # Make the EC2 instance accessible from 
  # anywhere on the internet through port 80
  ingress {
    description = "Allow all traffic through HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Make the EC2 instance accessible from 
  # Jenkins on the internet through port 8080
  ingress {
    description = "Custom"
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic from the instance
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "jenkins_security_group"
    Class = "jenkins"
  }
}

# Create a key pair for SSH 
resource "aws_key_pair" "jenkins_kp" {
  key_name = "jenkins_kp"

  # This is the public key 
  # to be shared with AWS
  public_key = file("jenkins_kp.pub")
}

# Create an EC2 instance 
resource "aws_instance" "jenkins_server" {
  # Set the number of instances needed
  count = var.instance_count

  # Set the AMI for EC2
  ami = data.aws_ami.amazon_linux.id

  # Set the instance type
  instance_type = var.instance_type

  # Set the id of the subnet 
  subnet_id = aws_subnet.jenkins_subnet[count.index].id

  # Set the key name of the key pair 
  key_name = aws_key_pair.jenkins_kp.key_name

  # Declare the security group ids
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  # Declare the script to execute 
  # when the instance is launched
  user_data = file("user_data.sh")

  tags = {
    Name  = "jenkins_server"
    Class = "jenkins"
  }
}

resource "aws_eip" "jenkins_eip" {
  count    = var.instance_count
  instance = aws_instance.jenkins_server[count.index].id
  vpc      = true
  tags = {
    Name  = "jenkins_elastic_ip"
    Class = "jenkins"
  }
}
