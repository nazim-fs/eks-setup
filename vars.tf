# AWS provider and backend variables
variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "aws-admin"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = "552601825397"
}

variable "s3_bucket" {
  description = "S3 bucket name for backend storage"
  type        = string
  default     = "rebtel-terraform-state-bucket"
}

variable "s3_key" {
  description = "S3 key for backend state file"
  type        = string
  default     = "rebtel-infra/dev/terraform.tfstate"
}

variable "dynamodb_table" {
  description = "DynamoDB table name for backend state locking"
  type        = string
  default     = "rebtel-terraform-lock"
}

# Environment tag
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

# Networking variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

# EKS variables
variable "eks_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.31"
}

variable "node_count" {
  description = "Number of nodes in the EKS node pool"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Instance type for EKS nodes"
  type        = string
  default     = "t3.medium"
}
