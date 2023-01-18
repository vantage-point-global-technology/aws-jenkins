# Define our Terraform settings
terraform {
  cloud {}
  # We only require the AWS provider
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
    }
  }
  # The version of Terraform
  # required to run this code
  required_version = ">= 1.2.0"
}

# Configure the AWS provider with the 
# region declared in our variables.tf
provider "aws" {
  region = var.aws_region
}