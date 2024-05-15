
###########################################
#
#//###################################### self nodegroup ##########################
#// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#// SPDX-License-Identifier: MIT-0
## Amazon EKS cluster data
data "aws_eks_cluster" "selected" {
  name = var.eks_cluster_name
  depends_on = [aws_eks_cluster.cluster]
}


# EC2 instance type data
data "aws_ec2_instance_type" "selected" {
  instance_type = var.instance_type
  depends_on = [aws_eks_cluster.cluster]
}





resource "aws_autoscaling_group" "eks_self_managed_node_group" {
  name = "${var.eks_cluster_name}-${local.node_group_name}"


  desired_capacity = var.desired_capacity
  min_size         = var.min_size

  max_size         = var.max_size

 # vpc_zone_identifier = var.subnets

  vpc_zone_identifier =  var.subnets

  launch_template {
    id      = aws_launch_template.eks_self_managed_nodes.id
    version = "$Latest"
  }



  # Ensure the IAM role has been created (and the policies have been attached)
  # before creating the auto-scaling group.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    aws_eks_cluster.cluster,
    aws_launch_template.eks_self_managed_nodes,
  #  kubernetes_config_map_v1_data.aws_auth,
  ]
}


resource "aws_launch_template" "eks_self_managed_nodes" {
  name_prefix = "${var.eks_cluster_name}-${local.node_group_name}"
  description = "Amazon EKS self-managed nodes"

  instance_type          = var.instance_type
  image_id               = "ami-06a9a2b789a408856"

  #ebs_optimized          = data.aws_ec2_instance_type.selected.ebs_optimized_support == "default" ? true : false
  key_name               = var.key_name
  update_default_version = true

  vpc_security_group_ids = concat(
    [data.aws_eks_cluster.selected.vpc_config[0].cluster_security_group_id],
    var.security_group_ids
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      "kubernetes.io/cluster/${aws_eks_cluster.cluster.name}" = "owned"
    }
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.eks_self_managed_node_group.arn
  }

#  block_device_mappings {
#    device_name = local.root_block_device_mapping.device_name
#
#    ebs {
#      snapshot_id = local.root_block_device_mapping.ebs.snapshot_id
#
#      encrypted  = coalesce(var.ebs_encrypted, local.root_block_device_mapping.ebs.encrypted)
#      kms_key_id = var.ebs_kms_key_arn
#
#      volume_size = coalesce(var.ebs_volume_size, local.root_block_device_mapping.ebs.volume_size)
#      volume_type = coalesce(var.ebs_volume_type, local.root_block_device_mapping.ebs.volume_type)
#      iops        = contains(["io1", "io2"], var.ebs_volume_type) ? var.ebs_iops : null
#      throughput  = var.ebs_volume_type == "gp3" ? var.ebs_throughput : null
#
#      delete_on_termination = coalesce(var.ebs_delete_on_termination, local.root_block_device_mapping.ebs.delete_on_termination)
#    }
#  }



  tags = var.tags


#  user_data = base64encode(templatefile("${path.module}/user_data.sh", {

    user_data = base64encode(templatefile("${path.cwd}/user_data.sh", {
    cluster_name = var.eks_cluster_name
    node_labels  = var.node_labels
  }))


}

