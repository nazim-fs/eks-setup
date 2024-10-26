module "networking" {
  source               = "./modules/networking"
  eks_cluster_name     = "rebtel-${var.environment}-eks-cluster"
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  aws_region           = var.aws_region
  environment          = var.environment
}

module "eks" {
  source           = "./modules/eks"
  eks_cluster_name = "rebtel-${var.environment}-eks-cluster"
  eks_version      = var.eks_version
  node_count       = var.node_count
  instance_type    = var.instance_type
  subnet_ids       = module.networking.private_subnets
  cluster_sg_id    = module.networking.cluster_sg_id
  node_sg_id       = module.networking.node_sg_id
  vpc_id           = module.networking.vpc_id
  environment      = var.environment
}
