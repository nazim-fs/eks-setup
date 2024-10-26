terraform {
  backend "s3" {
    bucket         = "rebtel-terraform-state-bucket"
    key            = "rebtel-infra/dev/terraform.tfstate"
    region         = "eu-central-1"
    profile        = "aws-admin"
    dynamodb_table = "rebtel-terraform-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1.0"
    }
  }
}

provider "aws" {
  profile             = var.aws_profile
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]

  default_tags {
    tags = {
      Project     = "Rebtel"
      Environment = var.environment
      Owner       = "Nazim"
      ManagedBy   = "Terraform"
    }
  }
}
