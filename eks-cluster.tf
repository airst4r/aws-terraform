locals {
  create = var.eks_cluster_create
}

module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  count = local.create ? 1 : 0
  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  authentication_mode = "API_AND_CONFIG_MAP"
  cluster_endpoint_public_access           = true
  cluster_endpoint_private_access          = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = aws_vpc.sstech.id
  subnet_ids = aws_subnet.sstech_public.*.id
  

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    disk_size = 50
    subnet_ids = aws_subnet.sstech_private.*.id

  }

  eks_managed_node_groups = {
    one = {
      name = "sstech-nodegroup-1"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 3
      key_name = "${var.ssh_key_name}"
    }

  }
}

