# aws-jenkins

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/vantage-point-global-technology/aws-jenkins/tree/main.svg?style=svg&circle-token=c6edb6bba9a046ebf74711601af47ee41e7bfe56)](https://dl.circleci.com/status-badge/redirect/gh/vantage-point-global-technology/aws-jenkins/tree/main)

Provision AWS VPC, public subnet, security group, route table and association, and an EC2 instance, and install Jenkins

## Prerequisites

- [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Github Account](https://github.com) for version control
- [Terraform Cloud Account](https://app.terraform.io/) for remote state storage
- [CircleCI Account](https://circleci.com/signup) for CI/CD

## Provision Jenkins on EC2

Create a key pair to SSH into EC2 
```
ssh-keygen -t rsa -b 4096 -m pem -f jenkins_kp && openssl rsa -in jenkins_kp -outform pem && chmod 400 jenkins_kp.pem
```
### Local Usage 

Grab your IP address from `https://checkip.amazonaws.com/` to use in `TF_VAR_local_ip` below.

Set environment variables in the terminal for the cloud storage
```
export TF_TOKEN_app_terraform_io=<REDACTED> 
export TF_CLOUD_ORGANIZATION=vantage-point-global 
export TF_WORKSPACE=aws-jenkins
export TF_VAR_local_ip=<READACTED>
```

Initialise Terraform
```
terraform init
```

Create a Terraform plan
```
terraform plan
```

Apply the plan
```
terraform apply
```

Note the public_ip in the terminal output

## Continuous Delivery (Recommended)
Set Environment Variables in Project Settings

| Name                      | Value                  | Source                                           |
| ------------------------- | ---------------------- | ------------------------------------------------ |
| TF_TOKEN_app_terraform_io | <REDACTED>             | Created in Terraform Cloud                       |
| TF_CLOUD_ORGANIZATION     | "vantage-point-global" | User created                                     |
| TF_WORKSPACE              | "aws-jenkins"          | User created                                     |
| TF_VAR_local_ip           | <REDACTED>             | Your IP address (https://checkip.amazonaws.com/) |



---------------

## Configuring Jenkins
Jenkins is now installed and running on your EC2 instance. To configure Jenkins:

1. Connect to http://<your_server_public_DNS>:8080 from your browser. You will be able to access Jenkins through its management interface:

![Unlock Jenkins](/assets/images/unlock_jenkins.png "Unlock Jenkins")

2. As prompted, enter the password found in /var/lib/jenkins/secrets/initialAdminPassword.

SSH in to the EC2 instance with the private key you created
```
ssh -i jenkins_kp ec2-user@<your_server_public_DNS>
```

Use the following command to display this password:
```
[ec2-user ~]$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

3. The Jenkins installation script directs you to the Customize Jenkins page. Click Install suggested plugins.

4. Once the installation is complete, the Create First Admin User will open. Enter your information, and then select Save and Continue.

![Admin User](/assets/images/create_admin_user.png "Create Admin User")

5. On the left-hand side, select Manage Jenkins, and then select Manage Plugins.

6. Select the Available tab, and then enter Amazon EC2 plugin at the top right.

7. Select the checkbox next to Amazon EC2 plugin, and then select Install without restart.

![EC2 Plugin](/assets/images/install_ec2_plugin.png "EC2 Plugin")

8. Once the installation is done, select Back to Dashboard.

9. Select Configure a cloud.

![Configure Cloud](/assets/images/configure_cloud.png "Configure Cloud")

10. Select Add a new cloud, and select Amazon EC2. A collection of new fields appears.

![Add new Cloud](/assets/images/add-amazon-cloud.png "Add new Cloud")

11. Click Add under Amazon EC2 Credentials

![Add EC2 Credentials](/assets/images/add_ec2_credentials.png "Add_EC2_Credentials")

12. From the Jenkins Credentials Provider, select AWS Credentials as the Kind.

![Select AWS Credentials](/assets/images/jenkins_credentials_provider_aws_credentials.png "select AWS Credentials as the Kind")

13. Scroll down and enter in the IAM User programmatic access keys with permissions to launch EC2 instances and select Add.

![Add Access Keys](/assets/images/add_access_secret_access_keys.png "Add IAM User programmatic access keys")

14. Scroll down to select your region using the drop-down, and select Add for the EC2 Key Pair’s Private Key.

![Configure Cloud Region](/assets/images/configure_cloud_region_private_key.png "Configure Cloud Region")

15. From the Jenkins Credentials Provider, select SSH Username with private key as the Kind and set the Username to ec2-user.

![SSH Username](/assets/images/ssh_username.png "SSH Username")

16. Scroll down and select Enter Directly under Private Key, then select Add.

![Private Key](/assets/images/private_key_enter_directly.png "Enter Private Key directly")

17. Open the private key pair you created in the creating a key pair step and paste in the contents from "-----BEGIN RSA PRIVATE KEY-----" to "-----END RSA PRIVATE KEY-----". Select Add when completed.

![Enter Private Key](/assets/images/enter_private_key.png "Enter Private Key")

18. Scroll down to "Test Connection" and ensure it states "Success". Select Save when done

![Test Connection](/assets/images/test_connection.png "Test Connection")

19. Configure SCM


Change user and generate a SSH key
![Jenkins SSH key](/assets/images/jenkins-ssh-key.png "Jenkins SSH key")

```
sudo -su jenkins 
```
Generate a key pair and add to ssh agent
```
ssh-keygen
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
```

20. Copy the public key
```
cat /var/lib/jenkins/.ssh/id_rsa.pub
```

21. Add the public key to your Github user account


22. Enable proxy compatibility

"Manage Jenkins" > "Configure Global Security" > "Enable proxy compatibility"

