data "aws_availability_zones" "available" {
  state = "available"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "cluster_sg_id" {
  value = aws_security_group.eks_cluster_sg.id
}

output "node_sg_id" {
  value = aws_security_group.eks_node_sg.id
}
