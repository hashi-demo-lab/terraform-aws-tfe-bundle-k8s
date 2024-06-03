
variable "vpc_id" {
  type    = string
}

variable "cluster_name" {
  type    = string
  default = "eks-cluster"
}

variable "cluster_endpoint" {
  type    = string
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "oidc_provider_arn" {
  type    = string
}

variable "cluster_certificate_authority_data" {
  type    = string
}