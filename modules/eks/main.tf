module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name              = var.eks_cluster_name
  cluster_version           = var.eks_version
  subnet_ids                = var.subnet_ids
  vpc_id                    = var.vpc_id
  enable_irsa               = true
  cluster_security_group_id = var.cluster_sg_id

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [var.node_sg_id]
  }

  eks_managed_node_groups = {

    rebtel_eks_nodes = {
      capacity_type = "SPOT"
      iam_role_name = aws_iam_role.eks_node_role.name
      min_size      = var.node_count
      max_size      = var.node_count + 1
      desired_size  = var.node_count
    }
  }

  tags = {
    Name = "rebtel-${var.environment}-eks-cluster"
  }
}
