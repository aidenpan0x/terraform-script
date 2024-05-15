// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

# -----------------------------------------------------------------------------
# Required input variables
# -----------------------------------------------------------------------------



variable "subnets" {
  type        = list(string)
  description = "(Required) A list of subnet IDs to launch nodes in. Subnets automatically determine which availability zones the node group will reside."
  default     = []

}
variable "eks_cluster_name" {
  type        = string
  default     = "stable-eks-0001"
  description = "(Required) The name of the Amazon EKS cluster."
}

