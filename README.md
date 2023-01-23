# aws-jenkins [![CircleCI](https://dl.circleci.com/status-badge/img/gh/vantage-point-global-technology/aws-jenkins/tree/main.svg?style=svg&circle-token=c6edb6bba9a046ebf74711601af47ee41e7bfe56)](https://dl.circleci.com/status-badge/redirect/gh/vantage-point-global-technology/aws-jenkins/tree/main)


## Provision AWS Virtual Network, EC2 and Jenkins
Provision a simple AWS Virtual Network and an EC2 instance with Jenkins installed for Continuous Delivery of AWS resources.

### Prerequisites

- [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (Optional)
- [Github Account](https://github.com) for version control
- [Terraform Cloud Account](https://app.terraform.io/) for remote state storage
- [CircleCI Account](https://circleci.com/signup) for CI/CD

#### Create a key pair to SSH into EC2

```
ssh-keygen -t rsa -b 4096 -m pem -f jenkins_kp && openssl rsa -in jenkins_kp -outform pem && chmod 400 jenkins_kp.pem
```

#### Get your IP address for secure EC2 access over SSH

- `https://checkip.amazonaws.com/`

## Set up instructions
- [CLI](./docs/LOCAL.md) (Only for local testing)
- [CircleCI](./docs/CI.md) (Recommended)
- [Configure Jenkins EC2](./docs/JENKINS_EC2.md) (Required)
- [Confugure Jekins GitHub](./docs/JENKINS_GITHUB.md) (Required)
