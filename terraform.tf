# Define our Terraform settings
terraform {
  # Set environment variables in the terminal when initialising
  # TF_TOKEN_app_terraform_io=<REDACTED> 
  # TF_CLOUD_ORGANIZATION=vantage-point-global 
  # TF_WORKSPACE=aws-jenkins terraform init
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