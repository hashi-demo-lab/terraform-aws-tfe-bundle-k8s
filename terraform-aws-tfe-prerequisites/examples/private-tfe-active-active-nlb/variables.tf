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

variable "vpc_enable_ssm" {
  type        = bool
  description = "Boolean that when true will create a security group allowing port 443 to the private_subnets within the VPC (if create_vpc is true)"
}

variable "airgap_bundle_path" {
  type        = string
  description = "Full path to where the airgap bundle is located. This will be uploaded to the s3 bucket during the run"
}

variable "tfe_release_sequence" {
  type        = string
  description = "Version of TFE to deploy."
  default     = 713
}

variable "airgap_bundle_name" {
  type        = string
  description = "Name of the airgap bundle (the key) in the bucket"
  default     = "tfe.airgap"
}

variable "replicated_bundle_path" {
  type        = string
  description = "Full path to the replicated bundle. This will be uploaded to the s3 bucket during the run"
}

variable "replicated_bundle_name" {
  type        = string
  description = "Name of the airgap bundle (the key) in the bucket"
  default     = "replicated.tar.gz"
}

variable "secretsmanager_secrets" {
  type = object({
    tfe = optional(object({
      license = optional(object({
        name        = optional(string, "tfe-license")
        description = optional(string, "License for TFE FDO")
        data        = optional(string, null)
        path        = optional(string, null)
      }))
      enc_password = optional(object({
        name        = optional(string, "enc-password")
        description = optional(string, "Encryption password used in the TFE installation")
        data        = optional(string, null)
        generate    = optional(bool, true)
      }))
      console_password = optional(object({
        name        = optional(string, "console-password")
        description = optional(string, "Console password used in the TFE installation")
        data        = optional(string, null)
        generate    = optional(bool, true)
      }))
    }))
    ca_certificate_bundle = optional(object({
      name        = optional(string, null)
      path        = optional(string, null)
      description = optional(string, "TFE BYO CA certificate bundle")
      data        = optional(string, null)
    }))
    cert_pem_secret = optional(object({
      name        = optional(string, null)
      path        = optional(string, null)
      description = optional(string, "TFE BYO PEM-encoded TLS certificate")
      data        = optional(string, null)
    }))
    cert_pem_private_key_secret = optional(object({
      name        = optional(string, null)
      path        = optional(string, null)
      description = optional(string, "TFE BYO PEM-encoded TLS private key")
      data        = optional(string, null)
    }))
    replicated_license = optional(object({
      name        = optional(string, "tfe-replicated-license")
      path        = optional(string, null)
      description = optional(string, "license")
      data        = optional(string, null)
    }))
  })
  description = "Object Map that contains various TFE secrets that will be created and stored in AWS Secrets Manager."
  default     = {}
}

variable "s3_buckets" {
  type = object({
    bootstrap = optional(object({
      create                              = optional(bool, true)
      bucket_name                         = optional(string, "tfe-bootstrap-bucket")
      description                         = optional(string, "Bootstrap bucket for the TFE instances and install")
      versioning                          = optional(bool, true)
      force_destroy                       = optional(bool, false)
      replication                         = optional(bool)
      replication_destination_bucket_arn  = optional(string)
      replication_destination_kms_key_arn = optional(string)
      replication_destination_region      = optional(string)
      encrypt                             = optional(bool, true)
      bucket_key_enabled                  = optional(bool, true)
      kms_key_arn                         = optional(string)
      sse_s3_managed_key                  = optional(bool, false)
      is_secondary_region                 = optional(bool, false)
    }), {})
    tfe_app = optional(object({
      create                              = optional(bool, true)
      bucket_name                         = optional(string, "tfe-app-bucket")
      description                         = optional(string, "Object store for TFE")
      versioning                          = optional(bool, true)
      force_destroy                       = optional(bool, false)
      replication                         = optional(bool)
      replication_destination_bucket_arn  = optional(string)
      replication_destination_kms_key_arn = optional(string)
      replication_destination_region      = optional(string)
      encrypt                             = optional(bool, true)
      bucket_key_enabled                  = optional(bool, true)
      kms_key_arn                         = optional(string)
      sse_s3_managed_key                  = optional(bool, false)
      is_secondary_region                 = optional(bool, false)
    }), {})
    logging = optional(object({
      create                              = optional(bool, true)
      bucket_name                         = optional(string, "hashicorp-log-bucket")
      versioning                          = optional(bool, false)
      force_destroy                       = optional(bool, false)
      replication                         = optional(bool, false)
      replication_destination_bucket_arn  = optional(string)
      replication_destination_kms_key_arn = optional(string)
      replication_destination_region      = optional(string)
      encrypt                             = optional(bool, true)
      bucket_key_enabled                  = optional(bool, true)
      kms_key_arn                         = optional(string)
      sse_s3_managed_key                  = optional(bool, false)
      lifecycle_enabled                   = optional(bool, true)
      lifecycle_expiration_days           = optional(number, 7)
      is_secondary_region                 = optional(bool, false)
    }), {})
  })
  description = "Object Map that contains the configuration for the S3 logging and bootstrap bucket configuration."
  default     = {}
}

variable "db_username" {
  type        = string
  description = "Username for the DB user."
  default     = "tfe"
}

variable "db_password" {
  type        = string
  description = "Password for the DB user."
  validation {
    condition     = can(regex("^[^$]*$", var.db_password))
    error_message = "The db_password cannot contain the $ character."
  }
}

variable "db_database_name" {
  type        = string
  description = "Name of the database that will be created and used"
}

variable "redis_password" {
  type        = string
  description = "Password (auth token) used to enable transit encryption (TLS) with Redis."
  validation {
    condition     = can(regex("^[^$]*$", var.redis_password))
    error_message = "The redis_password cannot contain the $ character."
  }
}

variable "lb_listener_details" {
  type = object({
    tfe_api = optional(object({
      create      = optional(bool, true)
      port        = optional(number, 443)
      ssl_policy  = optional(string, "ELBSecurityPolicy-2016-08")
      action_type = optional(string, "forward")
    }), {})
    tfe_console = optional(object({
      create      = optional(bool, true)
      port        = optional(number, 8800)
      ssl_policy  = optional(string, "ELBSecurityPolicy-2016-08")
      action_type = optional(string, "forward")
    }), {})
  })
  description = "Configures the LB Listeners for TFE"
  default     = {}
}

variable "lb_target_groups" {
  type = object({
    tfe_api = optional(object({
      create               = optional(bool, true)
      description          = optional(string, "Target Group for TLS API/Web application traffic")
      name                 = optional(string, "tfe-tls-tg")
      deregistration_delay = optional(number, 60)
      port                 = optional(number, 443)
      protocol             = optional(string, "HTTPS")
      health_check = optional(object({
        enabled             = optional(bool, true)
        port                = optional(number, 443)
        healthy_threshold   = optional(number, 2)
        unhealthy_threshold = optional(number, 3)
        timeout             = optional(number, 5)
        interval            = optional(number, 15)
        matcher             = optional(string, "200")
        path                = optional(string, "/_health_check")
        protocol            = optional(string, "HTTPS")
      }), {})
    }), {})
    tfe_console = optional(object({
      create               = optional(bool, true)
      name                 = optional(string, "tfe-console-tg")
      description          = optional(string, "Target Group for TFE/Replicated web admin console traffic")
      deregistration_delay = optional(number, 60)
      port                 = optional(number, 8800)
      protocol             = optional(string, "HTTPS")
      health_check = optional(object({
        enabled             = optional(bool, true)
        port                = optional(number, 8800)
        healthy_threshold   = optional(number, 2)
        unhealthy_threshold = optional(number, 3)
        timeout             = optional(number, 5)
        interval            = optional(number, 15)
        matcher             = optional(string, "200-299")
        path                = optional(string, "/ping")
        protocol            = optional(string, "HTTPS")
      }), {})
    }), {})
  })
  default     = {}
  description = "Object map that creates the LB target groups for the enterprise products"
}

variable "lb_type" {
  type        = string
  default     = "network"
  description = "Type of load balancer that will be provisioned as a part of the module execution (if specified)."
}

variable "iam_resources" {
  type = object({
    bucket_arns             = optional(list(string), [])
    kms_key_arns            = optional(list(string), [])
    secret_manager_arns     = optional(list(string), [])
    log_group_arn           = optional(string, "")
    log_forwarding_enabled  = optional(bool, true)
    role_name               = optional(string, "deployment-role")
    policy_name             = optional(string, "deployment-policy")
    ssm_enable              = optional(bool, false)
    custom_tbw_ecr_repo_arn = optional(string, "")
  })
  description = "A list of objects for to be referenced in an IAM policy for the instance.  Each is a list of strings that reference infra related to the install"
}

variable "route53_failover_record" {
  type = object({
    create              = optional(bool, true)
    set_id              = optional(string, "fso1")
    lb_failover_primary = optional(bool, true)
    record_name         = optional(string)
  })
  default     = {}
  description = "If set, creates a Route53 failover record.  Ensure that the record name is the same between both modules.  Also, the Record ID needs to be unique per module"
}

variable "lb_sg_rules_details" {
  type = object({
    tfe_api_ingress = optional(object({
      type        = optional(string, "ingress")
      create      = optional(bool, true)
      from_port   = optional(string, "443")
      to_port     = optional(string, "443")
      protocol    = optional(string, "tcp")
      cidr_blocks = optional(list(string), [])
      description = optional(string, "Allow 443 traffic inbound for TFE")
    }), {})
    tfe_console_ingress = optional(object({
      type        = optional(string, "ingress")
      create      = optional(bool, true)
      from_port   = optional(string, "8800")
      to_port     = optional(string, "8800")
      protocol    = optional(string, "tcp")
      cidr_blocks = optional(list(string), [])
      description = optional(string, "Allow 8800 traffic inbound for TFE")
    }), {})
    egress = optional(object({
      create      = optional(bool, true)
      type        = optional(string, "egress")
      from_port   = optional(string, "0")
      to_port     = optional(string, "0")
      protocol    = optional(string, "-1")
      cidr_blocks = optional(list(string), ["0.0.0.0/0"])
      description = optional(string, "Allow traffic outbound for TFE")
    }), {})
  })
  description = "Object map for various Security Group Rules as pertains to the Load Balancer for TFE"
  default     = {}
}

variable "ssh_public_key" {
  type        = string
  description = "Public key material for TFE SSH Key Pair."
  default     = null
}

variable "create_ssh_keypair" {
  type        = bool
  description = "Boolean to deploy TFE SSH key pair. This does not create the private key, it only creates the key pair with a provided public key."
  default     = false
}

variable "create_redis_replication_group" {
  description = "Boolean that determines if the pre-requisites for an active active deployment of TFE will be deployed."
  type        = bool
}

variable "tfe_active_active" {
  description = "Boolean that determines if the pre-requisites for an active active deployment of TFE will be deployed."
  type        = bool
}


variable "route53_zone_name" {
  type        = string
  description = "Route 53 public zone name"
  default     = ""
}

variable "product" {
  type        = string
  description = "Name of the HashiCorp product that will be installed (tfe, tfefdo, vault, consul)"
  validation {
    condition     = contains(["tfe", "tfefdo", "vault", "consul"], var.product)
    error_message = "`var.product` must be \"tfe\", \"tfefdo\", \"vault\", or \"consul\"."
  }
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

variable "log_forwarding_enabled" {
  type        = bool
  description = "Boolean that when true, will enable log forwarding to Cloud Watch"
  default     = true
}

variable "permit_all_egress" {
  type        = bool
  description = "Whether broad (0.0.0.0/0) egress should be permitted on cluster nodes. If disabled, additional rules must be added to permit HTTP(S) and other necessary network access."
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