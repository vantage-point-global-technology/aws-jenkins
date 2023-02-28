# aws-jenkins [![CircleCI](https://dl.circleci.com/status-badge/img/gh/vantage-point-global-technology/aws-jenkins/tree/main.svg?style=svg&circle-token=c6edb6bba9a046ebf74711601af47ee41e7bfe56)](https://dl.circleci.com/status-badge/redirect/gh/vantage-point-global-technology/aws-jenkins/tree/main)


## Provision AWS Virtual Network, EC2 and Jenkins
Provision a simple AWS Virtual Network and an EC2 instance with Jenkins installed for Continuous Delivery of AWS resources.

**For local usage**
- [Local CLI usage](./docs/LOCAL.md)

### Prerequisites

- [Github account](https://github.com) for version control
- [Terraform Cloud account](https://app.terraform.io/) for remote state storage
- [CircleCI account](https://circleci.com/signup) for CI/CD

#### Create a key pair to SSH into EC2

```
ssh-keygen -t rsa -b 4096 -m pem -f jenkins_kp && openssl rsa -in jenkins_kp -outform pem && chmod 400 jenkins_kp.pem
```

#### Get your IP address for secure EC2 access over SSH

- `https://checkip.amazonaws.com/`

## Instructions to set up Jenkins on EC2 and configure plugins and access
1. [CircleCI](./docs/CIRCLE_CI.md)
2. [Configure Jenkins EC2](./docs/JENKINS_EC2.md)
3. [Configure Jenkins GitHub](./docs/JENKINS_GITHUB.md)
4. [Configure Jenkins Terraform](./docs/JENKINS_TERRAFORM.md)
