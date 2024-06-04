
variable "vpc_id" {
  type = string
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "cluster_name" {
  type = string
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

#TFE HELM vars


variable "tfe_encryption_password" {}
variable "tfe_license" {}
variable "kms_key_arn" {}

variable "tfe_capacity_concurrency" { default = 100 }
variable "db_cluster_endpoint" { /*default = "tfe.c0ynn81zfwhe.ap-northeast-2.rds.amazonaws.com:5432"*/ }
variable "db_cluster_database_name" { default = "tfe" }
variable "tfe_database_parameters" { default = "sslmode=require" }
variable "tfe_database_user" { default = "tfe" }
variable "db_password" {}
variable "tfe_hostname" { /*default = "tfe.simon-lynch.sbx.hashidemos.io"*/ }
variable "tfe_iact_subnets" { default = "0.0.0.0/0" }
variable "s3_tfe_app_bucket_name" { /*default = "hashicorp-tfe-s3-common"*/ }
variable "tfe_object_storage_s3_endpoint" { default = "https://s3.ap-southeast-2.amazonaws.com" }
variable "tfe_object_storage_s3_region" { default = "ap-southeast-2" }
variable "tfe_object_storage_s3_server_side_encryption" { default = "aws:kms" }
variable "tfe_object_storage_s3_use_instance_profile" { default = "false" }
variable "tfe_object_storage_type" { default = "s3" }
variable "redis_primary_endpoint" {}
variable "redis_password" {}
variable "tfe_redis_use_auth" { default = "true" }
variable "tfe_redis_use_tls" { default = "true" }
variable "image_name" { default = "hashicorp/terraform-enterprise" }
variable "image_repository" { default = "images.releases.hashicorp.com" }
variable "image_tag" { default = "v202405-1" }
variable "replica_count" { default = 1 }
variable "service_type" { default = "ClusterIP" }
variable "metrics_enable" { default = true }
variable "metrics_http_port" { default = 9090 }
variable "metrics_https_port" { default = 9091 }
variable "private_http_port" { default = 8080 }
variable "private_https_port" { default = 8443 }
variable "cert_pem_secret" {}
variable "cert_pem_private_key_secret" {}
variable "ca_certificate_bundle"  {}
variable "tfe_irsa_role" {}