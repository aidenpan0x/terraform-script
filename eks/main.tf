############################################################

resource "aws_eks_cluster" "cluster" {
  name     = var.eks_cluster_name
  version  = var.eks_cluster_version
  role_arn = aws_iam_role.eks-cluster.arn


  vpc_config {

    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]

    subnet_ids = var.subnets
    #    [
    #      aws_subnet.private-ap-northeast-1c.id,
    #      aws_subnet.private-ap-northeast-1d.id,
    #      aws_subnet.public-ap-northeast-1c.id,
    #      aws_subnet.public-ap-northeast-1d.id
    #    ]
  }

  depends_on = [aws_iam_role_policy_attachment.amazon-eks-cluster-policy]
}



#resource "kubernetes_config_map" "aws-auth" {
#
#  data = {
#    "mapRoles" = <<EOT
#      - rolearn: arn:aws:iam::471112993982:role/${aws_iam_role.eks_self_managed_node_group.name}
#        username: system:node:{{EC2PrivateDNSName}}
#        groups:
#          - system:bootstrappers
#          - system:nodes
#EOT
#  }
#
#  metadata {
#    name      = "aws-auth"
#    namespace = "kube-system"
#  }
#  depends_on = [aws_eks_cluster.cluster]
#}





resource "aws_eks_addon" "vpc_cni" {
  count = var.addon_create_vpc_cni ? 1 : 0

  cluster_name  = aws_eks_cluster.cluster.name
  addon_name    = "vpc-cni"
#  resolve_conflicts_on_create = "OVERWRITE"
#  resolve_conflicts_on_update = "PRESERVE"
  addon_version = var.addon_vpc_cni_version
  #service_account_role_arn = module.irsa_vpc_cni.iam_role_arn

  lifecycle {
    ignore_changes = [cluster_name, addon_name]
  }
  tags = var.addon_tags

  depends_on = [aws_autoscaling_group.eks_self_managed_node_group]
}

# Configure cni daemonset to support higher pod density https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html

# This null_resource can be removed, when "aws_eks_addon" resource support configuration for addons
# 0r this issue https://github.com/hashicorp/terraform-provider-kubernetes/issues/723 to patch deployment


################################
# EKS Cluster kube proxy addon #
################################

resource "aws_eks_addon" "kube_proxy" {
  count = var.addon_create_kube_proxy ? 1 : 0

  cluster_name  = var.eks_cluster_name
  addon_name    = "kube-proxy"
  # resolve_conflicts_on_create = "OVERWRITE"
  # resolve_conflicts_on_update = "PRESERVE"
  addon_version = var.addon_kube_proxy_version

  tags       = var.addon_tags
  depends_on = [aws_autoscaling_group.eks_self_managed_node_group]
}

#############################
# EKS Cluster coredns addon #
#############################

#resource "aws_eks_addon" "coredns" {
#  count = var.addon_create_coredns ? 1 : 0
#
#  cluster_name      = var.eks_cluster_name
#  addon_name        = "coredns"
#  #resolve_conflicts_on_create = "OVERWRITE"
#  #resolve_conflicts_on_update = "OVERWRITE"
#  addon_version     = var.addon_coredns_version
#
#  tags = var.addon_tags
#  depends_on = [aws_autoscaling_group.eks_self_managed_node_group]
#}

resource "aws_eks_addon" "coredns" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "coredns"
  addon_version               = "v1.9.3-eksbuild.6"
#  resolve_conflicts_on_create = "OVERWRITE"
#  resolve_conflicts_on_update = "OVERWRITE"
  depends_on = [aws_autoscaling_group.eks_self_managed_node_group]
}


