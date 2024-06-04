
variable "vpc_id" {
  type = string
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "cluster_name" {
  type    = string
  default = "eks-cluster"
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "oidc_provider_arn" {
  type    = string
  default = null
}

variable "cluster_certificate_authority_data" {
  type = string
}



variable "iam_managed_policy_arn" {
  type = string
  description = "IAM policy arn for for TFE"
}

variable "tfe_namespace" {
  type    = string
  default = "tfe"
}