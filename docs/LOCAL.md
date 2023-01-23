# Local Usage (not recommended)
## Set environment variables for access to Terraform Cloud

**Find in your Terraform Cloud account**
```
export TF_TOKEN_app_terraform_io=<REDACTED> 
export TF_CLOUD_ORGANIZATION=vantage-point-global 
export TF_WORKSPACE=aws-jenkins
export TF_VAR_local_ip=<Your IP address>
```

### Initialise Terraform
```
terraform init
```

### Create a Terraform plan
```
terraform plan
```

### Apply the plan
```
terraform apply
```

