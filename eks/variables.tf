// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

# -----------------------------------------------------------------------------
# Required input variables
# -----------------------------------------------------------------------------



variable "eks_cluster_name" {
  type        = string
  default     = "stable-eks"
  description = "(Required) The name of the Amazon EKS cluster."
}


variable "aws_vpc_stable-eks_id" {
type        = string
default     = "vpc-0493956eb129e6c45"
description = "(Required) The name of the Amazon EKS cluster."
}


variable "eks_cluster_version" {
  type        = number
  default     = "1.25"
  description = "(Required) The name of the Amazon EKS cluster."
}
#addon


variable "eks_cluster_id" {
  description = "trigger for null resource using eks_cluster_id"
  default ="stable-eks"
}


variable "addon_create_vpc_cni" {
  description = "Create vpc_cni addon"
  type        = bool
  default     = true
}

variable "addon_create_kube_proxy" {
  description = "Create kube_proxy addon"
  type        = bool
  default     = true
}

variable "addon_create_coredns" {
  description = "Create coredns addon"
  type        = bool
  default     = true
}

variable "addon_vpc_cni_version" {
  default     = "v1.16.2-eksbuild.1"
  description = "Version for addon_create_vpc_cni"
  type = string
}

variable "addon_kube_proxy_version" {
  default     = "v1.25.16-eksbuild.1"
  description = "Version for addon_kube_proxy_version"
  type = string
}

variable "addon_coredns_version" {
  default     = "v1.9.3-eksbuild.10"
  description = "Version for addon_coredns_version"
  type = string
}

variable "cluster_oidc_issuer_url" {
  description = "Used to create the IAM OIDC role"
  type        = string
  default     = ""
}

variable "addon_tags" {
  default     = {}
  description = "Cluster addon tags"
  type        = map(string)
}



###################


variable "instance_type" {
  type        = string
  description = "(Required) The EC2 instance type to use for the worker nodes."
  default     = "c5.xlarge"
}

variable "desired_capacity" {
  type        = number
  description = "(Required) The desired number of nodes to create in the node group."
  default     = 1

}

variable "min_size" {
  type        = number
  description = "(Required) The minimum number of nodes to create in the node group."
  default     = 1

}

variable "max_size" {
  type        = number
  description = "(Required) The maximum number of nodes to create in the node group."
  default     = 1

}

variable "subnets" {
  type        = list(string)
  description = "(Required) A list of subnet IDs to launch nodes in. Subnets automatically determine which availability zones the node group will reside."
  default     = ["subnet-0c100ef60573bdd3d","subnet-0d9e21d152eff3350"]

}

variable "B64_CLUSTER_CA" {
  type        = string
  description = ""
  default     = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJZTNwQnVDSG05NUV3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBeE16RXdOelV5TVRkYUZ3MHpOREF4TWpnd056VTNNVGRhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUMvTzF6MnA2M2NWMkdHalpwWmRXMEhjWXdVTFBaRjZEOWE2d2xYNDU0K0hlck82NmQ1cnY0dzd1UlMKOWxGR2IxWFh1ekMrZFpPMVdDWkhvR0pnOUcyZmJCMklpRDlHUFpkNHRaOVFTY0R6MWRZTTRvbmtvYytHa3RuaAprL0xnd3RsbGR4NXJtdzJxWVpFOGljeTZ3UjVZVFdweXBnb0xVZXIxaDQ2VnhpRkljclNqRFNQVHY3b0dPTUhBCjNOWUtrQVdFajJMWm9Cc011VVhVL3RCNHNOcjMveWZmeGZxamxPYktpaHdjM3dEMUxlMkx1dnQ4dHMvaTZQTVkKeFFreVVWbFRkQ0pveVJId0FyRk1lbWVGa1BCMXVIcFZTd2JaRElVc3ozQWgrMk5EZ2gyWW5oa2JxZFF2dm9OdwpzZ01ZNllISGJVODRJS2I5OE13LzczaWp1ci9oQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJUS2RNM1pxRnVQU3lIMnNtcDE0WHVJR3VFWmpEQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ2JMU3lQMFh4dAp5UTBrTS9aWWYvR211V3F3UHR4SmtjS09lcWZyMEw4ZU02QnpVd1AvVDBQcTYzWXNFMWFRd0Q5MmxPUkpzT05iCmlRMWdVVGN0WGhSSnNWdkdQSFozYWxQa3NYM1c2dXBsM0t2Uk9rQk5tWGxXSm1IeGx6RHpnYkxWUDltYUJNalIKWmsyQlBOT1hEdythTGloTWZ5eFJWWTdYd1V5U1lzbmpsMkkvTEFFSlpGL3BObTdFeDdwSVRkdmRmeVNHem5lQgo3aFVZR2xmUUhjdkdUQzRvUTNQWjI5aDRJL1o5NUYvbnQxZ2owL05jaVdzczRzalRLQkRiQnpKTDRoYkI2aDd6CjNkdzZEbWZUQzFZRG5USitUVkRQNjJ2aWM0U0JlaXA3Y010S3ZuVlhDM0FIMFpYR2E5TklVWFlXVmJ0OFdVZ2UKUVJxQkRrUVN2YVZxCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
}







variable "pre_bootstrap_user_data" {
  description = "User data that is injected into the user data script ahead of the EKS bootstrap script. Not used when `platform` = `bottlerocket`"
  type        = string
  default     = ""
}

variable "post_bootstrap_user_data" {
  description = "User data that is appended to the user data script after of the EKS bootstrap script. Not used when `platform` = `bottlerocket`"
  type        = string
  default     = ""
}

variable "bootstrap_extra_args" {
  description = "Additional arguments passed to the bootstrap script. When `platform` = `bottlerocket`; these are additional [settings](https://github.com/bottlerocket-os/bottlerocket#settings) that are provided to the Bottlerocket user data"
  type        = string
  default     = ""
}

variable "user_data_template_path" {
  description = "Path to a local, custom user data template file to use when rendering user data"
  type        = string
  default     = ""
}



# -----------------------------------------------------------------------------
# Optional input variables
# -----------------------------------------------------------------------------
variable "name" {
  type        = string
  description = "(Optional) The name to be used for the self-managed node group. By default, the module will generate a unique name."
  default     = ""
}

variable "name_prefix" {
  type        = string
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with `name`."
  default     = "node-group"
}

variable "tags" {
  type        = map(any)
  description = "(Optional) Tags to apply to all tag-able resources."
  default     = {
#    "kubernetes.io/cluster/stable-eks" = "owned"
  }
}

variable "node_labels" {
  type        = map(any)
  description = "(Optional) Kubernetes labels to apply to all nodes in the node group."
  default     = {
  #  "kubernetes.io/cluster/stable-eks" = "owned"
  }
}

variable "key_name" {
  type        = string
  description = "(Optional) The name of the EC2 key pair to configure on the nodes."
  default     = "aiden-terraform-ops"
}

variable "security_group_ids" {
  type        = list(string)
  description = "(Optional) A list of security group IDs to associate with the worker nodes. The module automatically associates the EKS cluster security group with the nodes."
  default     = []
}

variable "ebs_encrypted" {
  type        = bool
  description = "(Optional) Enables EBS encryption on the volume. By default, the module uses the setting from the selected AMI."
  default     = null
}

variable "ebs_kms_key_arn" {
  type        = string
  description = "(Optional) The ARN of the AWS Key Management Service (AWS KMS) to use when creating the encrypted volume. `encrypted` must be set to true when this is set."
  default     = null
}

variable "ebs_volume_size" {
  type        = number
  description = "(Optional) The EBS volume size for a worker node. By default, the module uses the setting from the selected AMI."
  default     = null
}

variable "ebs_volume_type" {
  type        = string
  description = "(Optional) The EBS volume type for a worker node. By default, the module uses the setting from the selected AMI."
  default     = ""
}

variable "ebs_iops" {
  type        = number
  description = "(Optional) The amount of provisioned IOPS for a worker node. This must be set with an `ebs_volume_type` of `io1` or `io2`."
  default     = null
}

variable "ebs_throughput" {
  type        = number
  description = "(Optional) The throughput to provision for a `gp3` volume in MiB/s (specified as an integer)."
  default     = null
}

variable "ebs_delete_on_termination" {
  type        = number
  description = "(Optional) Whether the worker node EBS volumes should be destroyed on instance termination. By default, the module uses the setting from the selected AMI."
  default     = null
}


# -----------------------------------------------------------------------------
# Local variables
# -----------------------------------------------------------------------------
resource "random_id" "name_suffix" {
  byte_length = 8
}

locals {
  node_group_name = coalesce(var.name, "${var.name_prefix}-${random_id.name_suffix.hex}")
}