variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_version" {
  description = "EKS cluster version"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "cluster_sg_id" {
  description = "Cluster security group ID"
  type        = string
}

variable "node_sg_id" {
  description = "Nodes security group ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the EKS node pool"
  type        = number
}

variable "instance_type" {
  description = "Instance type for EKS nodes"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
