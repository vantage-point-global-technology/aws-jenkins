# CircleCI

1. Visit the [CircleCI project dashboard](https://app.circleci.com/projects/project-dashboard/github/vantage-point-global-technology/)
2. Click the "Set Up Project" button on the appropriate project
3. Use the "Fastest" option and click the "Set Up Project" button
4. Set the following Environment Variables in the Project Settings

| Name                      | Value                  | Source                                           |
| ------------------------- | ---------------------- | ------------------------------------------------ |
| AWS_ACCESS_KEY_ID         | <REDACTED>             | For AWS IAM user                                 |
| AWS_SECRET_ACCESS_KEY     | <REDACTED>             | For AWS IAM user                                 |
| TF_TOKEN_app_terraform_io | <REDACTED>             | Created in Terraform Cloud                       |
| TF_CLOUD_ORGANIZATION     | "vantage-point-global" | User created                                     |
| TF_WORKSPACE              | "aws-jenkins"          | User created                                     |
| TF_VAR_local_ip           | <REDACTED>             | Your IP address (https://checkip.amazonaws.com/) |

5. Make a change to the code in your aws-jenkins folder, stage and commit, then push to GitHub
6. [Visit the CircleCI project](https://app.circleci.com/pipelines/github/vantage-point-global-technology/aws-jenkins)
7. Go to the "apply" job and view the "terraform" section in "Steps"
8. Scroll to the bottom and copy the "public_dns"
9. [Configure Jenkins EC2](./JENKINS_EC2.md)