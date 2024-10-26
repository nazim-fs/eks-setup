# EKS Terraform Setup
This repository contains terraform setup to deploy an EKS cluster in AWS

## Description

This repository contains Terraform scripts to set up an Amazon EKS (Elastic Kubernetes Service) cluster on AWS. The setup includes provisioning a VPC, subnets, and the EKS cluster with the necessary configurations to manage a Kubernetes environment on AWS.

## Pre-requisites
Ensure you have the following tools installed and configured:

- **AWS CLI** - Used to interact with AWS services.
- **Terraform CLI** - Used to provision infrastructure as code.
- **Git CLI** - Used to clone and manage the repository.

## AWS Profile Configuration
The AWS CLI should be configured with a profile named aws-admin with sufficient permissions to create clusters and associated resources. Below are the necessary permissions for this setup:

- `AmazonEKSClusterPolicy`
- `AmazonEKSWorkerNodePolicy`
- `AmazonEKSCNIPolicy`
- `IAMFullAccess`
- `AmazonEC2FullAccess`
- `VPCFullAccess`

## Versions
This setup was tested on following tools version:

- **AWS CLI**: 2.18.3
- **Terraform**: 1.5.5
- **Git**: 2.39.3

## Setup

### Important Configuration Notes
- This setup assumes deployment in AWS account ID `552601825397`. If you wish to deploy in another account ID, please update the `aws_account_id` variable in `vars.tf`.

- Additionally, this setup stores the Terraform state file in an S3 bucket named `rebtel-terraform-state-bucket`, with a DynamoDB table named `rebtel-terraform-lock` for state locking. **Please change these values in the backend configuration within the `providers.tf` file** if using different resources.

### Step 1: Clone Repository
Clone the repository to your local machine and navigate into the directory:
```
git clone git@github.com:nazim-fs/eks-terraform-setup.git
cd eks-terraform-setup
```

### Step 2: Initialize Terraform
Initialize Terraform to download necessary plugins and prepare the environment:
```
terraform init
```

### Step 3: Validate Terraform
To check for any syntax issues in your configurations, run:
```
terraform validate
```

### Step 4: Plan Terraform (Optional)
This step is optional but recommended for checking what resources Terraform will create or modify:
```
terraform plan
```

## Step 5: Apply Terraform
Deploy the infrastructure using the following command. Confirm the action when prompted:
```
terraform apply
```

## Outputs
After Terraform completes, it will output important information required to interact with the EKS cluster. This includes:

- cluster_endpoint: The API endpoint for the EKS cluster.
```
cluster_endpoint = "https://778E2210112......."
```
- cluster_security_group_id: Security group associated with the EKS cluster.
```
cluster_security_group_id = "sg-019bf....."
```
- oidc_provider_arn: ARN of the OIDC provider for the EKS cluster.
```
oidc_provider_arn = "arn:aws:iam::552601825....."
```
- region: AWS region where the cluster is deployed.
```
region = "eu-central-1"
```

## Destroy Terraform (Be Cautious)
To delete all resources created by Terraform, use this command. Please ensure to review the resouces that are getting destroyed before running this command:
```
terraform destroy
```
