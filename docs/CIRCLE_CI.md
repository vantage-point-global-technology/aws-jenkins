# CircleCI

## Set Environment Variables in CircleCI Project Settings

| Name                      | Value                  | Source                                           |
| ------------------------- | ---------------------- | ------------------------------------------------ |
| AWS_ACCESS_KEY_ID         | <REDACTED>             | For AWS IAM user                                 |
| AWS_SECRET_ACCESS_KEY     | <REDACTED>             | For AWS IAM user                                 |
| TF_TOKEN_app_terraform_io | <REDACTED>             | Created in Terraform Cloud                       |
| TF_CLOUD_ORGANIZATION     | "vantage-point-global" | User created                                     |
| TF_WORKSPACE              | "aws-jenkins"          | User created                                     |
| TF_VAR_local_ip           | <REDACTED>             | Your IP address (https://checkip.amazonaws.com/) |

**Save and commit local changes, and push to the main project branch in GitHub to trigger a build on CircleCI**

**Follow the pipeline jobs and approve to apply the changes**