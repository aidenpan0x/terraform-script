



#
#data "aws_eks_cluster" "right-eks" {
#  name = var.eks_cluster_name
#  depends_on = [aws_eks_cluster.cluster]
#}
#
#data "aws_eks_node_group" "right-ng" {
#  cluster_name    = var.eks_cluster_name
#  node_group_name = aws_autoscaling_group.eks_self_managed_node_group.name
#  depends_on = [aws_eks_cluster.cluster]
#}
#
#data "aws_eks_cluster_auth" "right-auth" {
#  name = var.eks_cluster_name
#  depends_on = [aws_eks_cluster.cluster]
#}


#provider "kubernetes" {
## host                   = data.aws_eks_cluster.right-eks.endpoint
## cluster_ca_certificate = base64decode(data.aws_eks_cluster.right-eks.certificate_authority[0].data)
###  token                  = data.aws_eks_cluster_auth.right-auth.token
#}





data "aws_eks_cluster" "default" {
  name = var.eks_cluster_name
  depends_on = [aws_eks_cluster.cluster]
}

data "aws_eks_cluster_auth" "default" {
  name = var.eks_cluster_name
  depends_on = [aws_eks_cluster.cluster]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}



resource "kubernetes_config_map_v1_data" "aws_auth" {
  provider = kubernetes


  force    = true
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  #  data = local.aws_auth_configmap_data
  data = {
    mapRoles = yamlencode(concat(
      [
        {
          rolearn  = aws_iam_role.eks_self_managed_node_group.arn
          username = "system:node:{{EC2PrivateDNSName}}"
          groups   = [
            "system:bootstrappers",
            "system:nodes",
          ]
        },
        {
          rolearn  = aws_iam_instance_profile.eks_self_managed_node_group.role
          username = "system:node:{{EC2PrivateDNSName}}"
          groups   = [
            "system:bootstrappers",
            "system:nodes",
          ]
        },
      ],
      #         var.aws_auth_roles
    ))
    # if required
    #    mapUsers = yamlencode(var.aws_auth_users)
    # if required
    #    mapAccounts = yamlencode(var.aws_auth_accounts)
  }

  depends_on = [aws_eks_cluster.cluster,aws_eks_node_group.private-nodes]

}