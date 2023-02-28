# aws-jenkins [![CircleCI](https://dl.circleci.com/status-badge/img/gh/vantage-point-global-technology/aws-jenkins/tree/main.svg?style=svg&circle-token=c6edb6bba9a046ebf74711601af47ee41e7bfe56)](https://dl.circleci.com/status-badge/redirect/gh/vantage-point-global-technology/aws-jenkins/tree/main)

## Provision AWS Virtual Network, EC2 and Jenkins
Provision a simple AWS Virtual Network and an EC2 instance with Jenkins installed for Continuous Delivery of AWS resources.

[Local testing only](./docs/LOCAL.md)

### Prerequisites

- Create a [Github account](https://github.com) to save your code
- Create a [Terraform Cloud account](https://app.terraform.io/) for remote Terraform state
- Create a [CircleCI account](https://circleci.com/signup) to deploy your code
- Get [your IP address](https://checkip.amazonaws.com/) for secure EC2 access over SSH 
- Create a key pair to SSH into EC2
```
ssh-keygen -t rsa -b 4096 -m pem -f jenkins_kp && openssl rsa -in jenkins_kp -outform pem && chmod 400 jenkins_kp.pem
```

## Get started
1. Clone this project 
```
git clone git@github.com:vantage-point-global-technology/aws-jenkins.git
```
2. [Set up the CircleCI project](./docs/CIRCLE_CI.md)
3. [Configure Jenkins EC2](./docs/JENKINS_EC2.md)
4. [Configure Jenkins GitHub](./docs/JENKINS_GITHUB.md)
5. [Configure Jenkins Terraform](./docs/JENKINS_TERRAFORM.md)
