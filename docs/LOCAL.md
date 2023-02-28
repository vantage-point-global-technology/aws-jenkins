# Local Usage (for testing only)

Open a terminal on your computer and set the following environment variables

## Prerequisites
- [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Set environment variables for access to Terraform Cloud

```
export TF_TOKEN_app_terraform_io="<REDACTED>"
export TF_CLOUD_ORGANIZATION="vantage-point-global"
export TF_WORKSPACE="aws-jenkins"
export TF_VAR_local_ip=<Your IP address>
```

- Set environment variables for access to AWS
```
export AWS_ACCESS_KEY_ID="<REDACTED>"
export AWS_SECRET_ACCESS_KEY="<REDACTED>"
```

## Run Terraform 
### Initialise Terraform
```
terraform init
```

### Create a Terraform plan
```
terraform plan
```

### Create the AWS services
```
terraform apply
```

### Destroy the AWS services
```
terraform destroy
```