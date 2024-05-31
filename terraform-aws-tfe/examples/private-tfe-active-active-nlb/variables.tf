variable "region" {
  type        = string
  description = "AWS Region"
}

variable "friendly_name_prefix" {
  type        = string
  description = "Friendly name prefix used for tagging and naming AWS resources."
}

variable "common_tags" {
  type        = map(string)
  description = "Map of common tags for all taggable AWS resources."
  default     = {}
}
#------------------------------------------------------------------------------
# Networking
#------------------------------------------------------------------------------
variable "vpc_id" {
  type        = string
  description = "VPC ID that TFE will be deployed into."
}

variable "ec2_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to use for the EC2 instance. Private subnets is the best practice."
}

variable "permit_all_egress" {
  type        = bool
  description = "Whether broad (0.0.0.0/0) egress should be permitted on cluster nodes. If disabled, additional rules must be added to permit HTTP(S) and other necessary network access."
}

#------------------------------------------------------------------------------
# Loadbalancing
#------------------------------------------------------------------------------
variable "lb_type" {
  type        = string
  description = "String indicating whether the load balancer deployed is an Application Load Balancer (alb) or Network Load Balancer (nlb)."
}

variable "lb_tg_arns" {
  type        = list(any)
  description = "List of Target Group ARNs associated with the TFE Load Balancer"
}

#------------------------------------------------------------------------------
# Secret Manager
#------------------------------------------------------------------------------

variable "tfe_cert_secret_arn" {
  type        = string
  description = "ARN of AWS Secrets Manager secret for TFE server certificate in PEM format. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored."
}

variable "ca_bundle_secret_arn" {
  type        = string
  description = "ARN of AWS Secrets Manager secret for private/custom CA bundles. New lines must be replaced by `\n` character prior to storing as a plaintext secret."
}

variable "tfe_privkey_secret_arn" {
  type        = string
  description = "ARN of AWS Secrets Manager secret for TFE private key in PEM format and base64 encoded. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored."
}

variable "tfe_secrets_arn" {
  type        = string
  description = "ARN of the secret in AWS Secrets Manager that contains all of the TFE secrets"
}

variable "replicated_license_secret_arn" {
  type        = string
  description = "ARN of the secret in AWS Secrets Manager that contains all of the TFE Replicated license"
}

#------------------------------------------------------------------------------
# Database
#------------------------------------------------------------------------------
variable "db_database_name" {
  type        = string
  description = "Name of database that will be created (if specified) or consumed by TFE."
}

variable "db_username" {
  type        = string
  description = "Username for the DB user."
}

variable "db_password" {
  type        = string
  description = "Password for the DB user."
  validation {
    condition     = can(regex("^[^$]*$", var.db_password))
    error_message = "The db_password cannot contain the $ character."
  }
}

variable "db_cluster_endpoint" {
  description = "Writer endpoint for the database cluster."
  type        = string
}

#------------------------------------------------------------------------------
# Redis
#------------------------------------------------------------------------------
variable "redis_password" {
  type        = string
  description = "Password (auth token) used to enable transit encryption (TLS) with Redis."
  validation {
    condition     = can(regex("^[^$]*$", var.redis_password))
    error_message = "The redis_password cannot contain the $ character."
  }
}

variable "redis_host" {
  type        = string
  description = "Endpoint url for the Redis replication group that TFE should connect to."
}

variable "redis_security_group_id" {
  type        = string
  description = "Existing security group ID that is attatched to the redis cluster. This will be used when adding rules to access the cluster from the TFE instances."
}

#------------------------------------------------------------------------------
# TFE Configuration
#------------------------------------------------------------------------------
variable "tfe_active_active" {
  description = "Boolean that determines if the pre-requisites for an active active deployment of TFE will be deployed."
  type        = bool
}

variable "tfe_release_sequence" {
  type        = any
  description = "TFE release sequence number within Replicated. This specifies which TFE version to install for an `online` install. Ignored if `airgap_install` is `true`."
  default     = "733"
}

variable "tfe_hostname" {
  type        = string
  description = "FQDN of the TFE deployment."
}

variable "product" {
  type        = string
  description = "Name of the HashiCorp product that will be installed (tfe, tfefdo, vault, consul)"
  validation {
    condition     = contains(["tfe", "tfefdo", "vault", "consul"], var.product)
    error_message = "`var.product` must be \"tfe\", \"tfefdo\", \"vault\", or \"consul\"."
  }
  default = "tfe"
}

variable "ssh_keypair_name" {
  type        = string
  description = "Name of the SSH public key to associate with the TFE instances."
  default     = null
}

variable "tls_bootstrap_type" {
  type        = string
  description = "Defines where to terminate TLS/SSL. Set to `self-signed` to terminate at the load balancer, or `server-path` to terminate at the instance-level."
  default     = "self-signed"

  validation {
    condition     = contains(["self-signed", "server-path"], var.tls_bootstrap_type)
    error_message = "Supported values are `self-signed` or `server-path`."
  }
}

variable "asg_hook_value" {
  type        = string
  description = "Value for the tag that is associated with the launch template. This is used for the lifecycle hook checkin."
}

variable "replicated_bundle_path" {
  type        = string
  description = "Path to Replicated tarball (`replicated.tar.gz`) stored in `tfe_bootstrap_bucket`. Path should start with `s3://`. Only specify if `airgap_install` is `true`."
  default     = ""

  validation {
    condition     = length(var.replicated_bundle_path) > 5 && substr(var.replicated_bundle_path, 0, 5) == "s3://" || var.replicated_bundle_path == ""
    error_message = "Value must start with \"s3://\"."
  }
}

variable "tfe_airgap_bundle_path" {
  type        = string
  description = "Path to TFE airgap bundle stored in `tfe_bootstrap_bucket`. Path should start with `s3://`. Only specify if `airgap_install` is `true`."
  default     = ""

  validation {
    condition     = length(var.tfe_airgap_bundle_path) > 5 && substr(var.tfe_airgap_bundle_path, 0, 5) == "s3://" || var.tfe_airgap_bundle_path == ""
    error_message = "Value must start with \"s3://\"."
  }
}

#------------------------------------------------------------------------------
# KMS
#------------------------------------------------------------------------------

variable "kms_key_arn" {
  type        = string
  description = "ARN of KMS key to encrypt TFE RDS, S3, EBS, and Redis resources."
}

#------------------------------------------------------------------------------
# IAM
#------------------------------------------------------------------------------

variable "iam_profile_name" {
  type        = string
  description = "Name of AWS IAM Instance Profile for TFE EC2 Instance"
}

#------------------------------------------------------------------------------
# S3
#------------------------------------------------------------------------------

variable "s3_app_bucket_name" {
  type        = string
  description = "Name of S3 Terraform Enterprise Object Store bucket."
}

variable "s3_log_bucket_name" {
  type        = string
  description = "Name of bucket to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`."
  default     = ""
}

#------------------------------------------------------------------------------
# Logging
#------------------------------------------------------------------------------

variable "cloudwatch_log_group_name" {
  type        = string
  description = "Name of CloudWatch Log Group to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`."
  default     = ""
}

variable "log_forwarding_enabled" {
  type        = bool
  description = "Boolean to enable TFE log forwarding at the application level."
  default     = false
}

variable "log_forwarding_type" {
  type        = string
  description = "Which type of log forwarding to configure. For any of these,`var.log_forwarding_enabled` must be set to `true`. For  S3, specify `s3` and supply a value for `var.s3_log_bucket_name`, for Cloudwatch specify `cloudwatch` and `var.cloudwatch_log_group_name`, for custom, specify `custom` and supply a valid fluentbit config in `var.custom_fluent_bit_config`."
  default     = "s3"

  validation {
    condition     = contains(["s3", "cloudwatch", "custom"], var.log_forwarding_type)
    error_message = "Supported values are `s3`, `cloudwatch` or `custom`."
  }
}
