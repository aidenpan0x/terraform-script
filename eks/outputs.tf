################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = aws_eks_cluster.cluster.arn
}

output "aws_iam_role_eks_cluster" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.cluster.role_arn
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = aws_eks_cluster.cluster.endpoint
}


#output "cluster_id" {
#  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
#  value       = try(aws_eks_cluster.cluster.[0].cluster_id, "")
#}
#
#output "cluster_name" {
#  description = "The name of the EKS cluster"
#  value       = try(aws_eks_cluster.cluster.[0].name, "")
#}
#
#output "cluster_oidc_issuer_url" {
#  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
#  value       = try(aws_eks_cluster.cluster.[0].identity[0].oidc[0].issuer, null)
#}
#
#output "cluster_version" {
#  description = "The Kubernetes version for the cluster"
#  value       = try(aws_eks_cluster.cluster.[0].version, null)
#}
#
#output "cluster_platform_version" {
#  description = "Platform version for the cluster"
#  value       = try(aws_eks_cluster.cluster.[0].platform_version, null)
#}
#
#output "cluster_status" {
#  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
#  value       = try(aws_eks_cluster.cluster.[0].status, null)
#}
#
#output "cluster_primary_security_group_id" {
#  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
#  value       = try(aws_eks_cluster.cluster.[0].vpc_config[0].cluster_security_group_id, null)
#}
#
#

################################################################################
# Cluster Security Group
################################################################################

#output "cluster_security_group_arn" {
#  description = "Amazon Resource Name (ARN) of the cluster security group"
#  value       = try(aws_security_group.cluster[0].arn, null)
#}
#
#output "cluster_security_group_id" {
#  description = "ID of the cluster security group"
#  value       = try(aws_security_group.cluster[0].id, null)
#}

################################################################################
# Node Security Group
################################################################################

#output "node_security_group_arn" {
#  description = "Amazon Resource Name (ARN) of the node shared security group"
#  value       = try(aws_security_group.node[0].arn, null)
#}
#
#output "node_security_group_id" {
#  description = "ID of the node shared security group"
#  value       = try(aws_security_group.node[0].id, null)
#}

################################################################################
# IRSA
################################################################################

#output "oidc_provider" {
#  description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
#  value       = try(replace(aws_eks_cluster.cluster.this[0].identity[0].oidc[0].issuer, "https://", ""), null)
#}
#
#output "oidc_provider_arn" {
#  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
#  value       = try(aws_iam_openid_connect_provider.oidc_provider[0].arn, null)
#}
#
#output "cluster_tls_certificate_sha1_fingerprint" {
#  description = "The SHA1 fingerprint of the public key of the cluster's certificate"
#  value       = try(data.tls_certificate.this[0].certificates[0].sha1_fingerprint, null)
#}

################################################################################
# IAM Role
################################################################################

#output "cluster_iam_role_name" {
#  description = "IAM role name of the EKS cluster"
#  value       = try(aws_iam_role.this[0].name, null)
#}
#
#output "cluster_iam_role_arn" {
#  description = "IAM role ARN of the EKS cluster"
#  value       = try(aws_iam_role.this[0].arn, null)
#}
#
#output "cluster_iam_role_unique_id" {
#  description = "Stable and unique string identifying the IAM role"
#  value       = try(aws_iam_role.this[0].unique_id, null)
#}

################################################################################
# EKS Addons
################################################################################

#output "cluster_addons" {
#  description = "Map of attribute maps for all EKS cluster addons enabled"
#  value       = merge(aws_eks_addon.this, aws_eks_addon.before_compute)
#}

################################################################################
# EKS Identity Provider
################################################################################

#output "cluster_identity_providers" {
#  description = "Map of attribute maps for all EKS identity providers enabled"
#  value       = aws_eks_identity_provider_config.this
#}

################################################################################
# CloudWatch Log Group
################################################################################

#output "cloudwatch_log_group_name" {
#  description = "Name of cloudwatch log group created"
#  value       = try(aws_cloudwatch_log_group.this[0].name, null)
#}
#
#output "cloudwatch_log_group_arn" {
#  description = "Arn of cloudwatch log group created"
#  value       = try(aws_cloudwatch_log_group.this[0].arn, null)
#}

################################################################################
# Fargate Profile
################################################################################



################################################################################
# EKS Managed Node Group
################################################################################

#output "eks_managed_node_groups" {
#  description = "Map of attribute maps for all EKS managed node groups created"
#  value       = module.eks_managed_node_group
#}
#
#output "eks_managed_node_groups_autoscaling_group_names" {
#  description = "List of the autoscaling group names created by EKS managed node groups"
#  value       = compact(flatten([for group in module.eks_managed_node_group : group.node_group_autoscaling_group_names]))
#}

################################################################################
# Self Managed Node Group
################################################################################

output "self_managed_node_group" {
  description = "Map of attribute maps for all self managed node groups created"
  value       = aws_autoscaling_group.eks_self_managed_node_group.name
}


output "self_managed_role_arns" {
  description = "self managed node groups arn"
  value       = aws_autoscaling_group.eks_self_managed_node_group.arn
}

output "aws_iam_roe_self_managed_role_arns" {
  description = "self managed node groups arn"
  value       = aws_iam_instance_profile.eks_self_managed_node_group.role
}

output "aws_iam_role_eks_self_managed_node_group" {
  description = "self managed node groups arn"
  value       = aws_iam_role.eks_self_managed_node_group.arn
}

#output "self_managed_node_groups_autoscaling_group_names" {
#  description = "List of the autoscaling group names created by self-managed node groups"
#  value       = compact([for group in module.self_managed_node_group : group.autoscaling_group_name])
#}

################################################################################
# Additional
################################################################################

#output "aws_auth_configmap_yaml" {
#  description = "[DEPRECATED - use `var.manage_aws_auth_configmap`] Formatted yaml output for base aws-auth configmap containing roles used in cluster node groups/fargate profiles"
#  value = templatefile("${path.module}/aws_auth_cm.tpl",
#    {
#      eks_managed_role_arns                   = distinct(compact([for group in module.eks_managed_node_group : group.iam_role_arn]))
#      self_managed_role_arns                  = distinct(compact([for group in module.self_managed_node_group : group.iam_role_arn if group.platform != "windows"]))
#      win32_self_managed_role_arns            = distinct(compact([for group in module.self_managed_node_group : group.iam_role_arn if group.platform == "windows"]))
#      fargate_profile_pod_execution_role_arns = distinct(compact([for group in module.fargate_profile : group.fargate_profile_pod_execution_role_arn]))
#    }
#  )
#}