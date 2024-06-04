
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

variable "iam_role_name" {
  type = string
  description = "IAM role name for for TFE"
}

variable "iam_role_arn" {
  type = string
  description = "IAM role arn for for TFE"
}