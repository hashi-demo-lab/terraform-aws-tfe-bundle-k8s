variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "cluster_name" {
  type    = string
  default = "eks-tfe"
}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}

variable "tfc_hostname" {
  type    = string
  default = "https://app.terraform.io"
}

variable "tfc_kubernetes_audience" {
  type    = string
  default = "k8s.workload.identity"
}

variable "eks_clusteradmin_arn" {
  type    = string
  default = null
}

variable "eks_clusteradmin_username" {
  type    = string
  default = null
}

variable "vpc_security_group_ids" {
  type    = string
  default = null
} 