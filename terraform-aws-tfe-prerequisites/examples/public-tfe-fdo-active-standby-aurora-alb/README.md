# Public TFE (FDO) Active-Standby with an NLB Example

This module is an example of utilizing the `terraform-aws-tfe-prerequisites` module. Users can use this to deploy prerequisite infrastructure required to install Terraform Enterprise into AWS in 2 separate regions.

## Description

This module showcases an example of utilizing the root module of this repository to build out the following high level components for a Public TFE **Multi-site** deployment inside of AWS in a **multiple region**:  

**Root Module**  
-  VPC with Public and Private access at both primary and secondary sites
-  VPC Endpoints at both primary and secondary sites
-  Secrets Manager Secrets at both primary and secondary sites
-  S3 buckets at both primary and secondary sites
-  S3 Cross Region Replication  
-  Global Aurora PostgreSQL cluster 
-  Route 53 entries (Regional record and Failover record)  
-  Application Load Balancer, Listeners, and Target Groups  at both primary and secondary sites
-  Certificate for Application Load Balancers
-  KMS Encryption Keys  at both primary and secondary sites
-  Log Groups for TFE  at both primary and secondary sites
-  TFE KeyPair for TFE  at both primary and secondary sites

**TFE Module Primary and Secondary Regions**  
-  TFE EC2 AutoScaling Group (in secondary region, the ASG replica count is set to 0)  
-  TFE EC2 Launch Template at both primary and secondary sites


## Getting Started

### Dependencies

* Terraform or Terraform Cloud for seeding
* Route53 Zone
* A valid certificate for TFE.
* TFE License (Replicated)

---

### 📝 Note
If you already have the prerequisites created, please see the other repository for the examples that focus on the deployment of the product only rather than the underlying infrastructre. They can be found here [terraform-aws-tfe](https://github.com/hashicorp-modules/terraform-aws-tfe) module under `/examples/`.  

#### Supplemental Modules
>There is a **supplemental-modules** folder and within that there is some sample code that will generate a certificate with LetsEncrypt. If you do not have certificates prepared, you can modified the values in `supplemental-modules/generate-cert/terraform-auto.tfvars` and then do a `terraform plan` and `terraform apply`. This will create certificates within the `generate-cert` folder that can be referenced in the main run.

---

### Executing program

Modify the `terraform.auto.tfvars.example` file with parameters pertinent to your environment.  As part of the example, some settings are pre-selected or marked as recommended or required. 


``` hcl
terraform init
terraform plan
terraform apply
```

The deployment will take roughly 14-30 minutes to complete.  

---

## Deployment of TFE  

Note that this module is designed to create the necessary pre-requisite infrastructure within AWS to prepare for the deployment of TFE on EC2.  Once the deployment completes, utilize a different workspace to manage the deployment of TFE on AWS, separating state and responsibilities.  **We have kept the end-to-end deployment outlined here for the sake of demos**

---

## Failover Testing steps

>**📝 Note**
>
>This assumes you have already deployed the example. We are mimicing a controlled failover as a part of the first portion and a DB failing over without TFE being aware in the second half. This assumes you have already deployed the example. We are mimicing a controlled failover as a part of the first portion and a DB failing over without TFE being aware in the second half. The replication policies currently only replicated to the secondary site but don't replicate back. If you need to replicated the data in S3 back, Add a replication policy to replicate the data back to your primary region.

1. Change the `asg_instance_count = 1` to `0` for the `primary_tfe` module call and change `asg_min_size = 1` to `0` for the `primary_tfe` module call.
2. `terraform apply`
3. Login to AWS and failover the aurora cluster to the secondary region.
4. Change `asg_instance_count = 0` to `1` for the `secondary_tfe` module call and change the `asg_min_size = 0` to `1` for the `secondary_tfe` module call.
5. `terrform apply`
6. Retry the tfe url after about 7 minutes and make sure it works. Might need to use a different browser or incognito.
7. Login to AWS and failover the database cluster to mimic it dropping.
8. Change `asg_instance_count = 0` to `1` for `primary_tfe` and `asg_instance_count = 1` to `0` for the `secondary_tfe` module call.
9. Change `asg_min_size = 0` to `1` for `primary_tfe` and `asg_min_size = 1` to `0` for the `secondary_tfe` module call.
10. `terraform apply`
11. Retry the tfe url after about 7 minutes once the run is complete. Ensure that the changes you made from the second site is present when you failed back.

---

## Authors

* Kalen Arndt  
* Sean Doyle  


## Acknowledgments

HashiCorp IS and HashiCorp Engineering have been huge inspirations for this effort


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.55.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pre_req_primary"></a> [pre\_req\_primary](#module\_pre\_req\_primary) | ../../ | n/a |
| <a name="module_pre_req_secondary"></a> [pre\_req\_secondary](#module\_pre\_req\_secondary) | ../../ | n/a |
| <a name="module_primary_tfe"></a> [primary\_tfe](#module\_primary\_tfe) | github.com/hashicorp-modules/terraform-aws-tfe | v1.0.4 |
| <a name="module_secondary_tfe"></a> [secondary\_tfe](#module\_secondary\_tfe) | github.com/hashicorp-modules/terraform-aws-tfe | v1.0.4 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_database_name"></a> [db\_database\_name](#input\_db\_database\_name) | Name of the database that will be created and used | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the DB user. | `string` | n/a | yes |
| <a name="input_friendly_name_prefix"></a> [friendly\_name\_prefix](#input\_friendly\_name\_prefix) | Friendly name prefix used for tagging and naming AWS resources. | `string` | n/a | yes |
| <a name="input_iam_resources"></a> [iam\_resources](#input\_iam\_resources) | A list of objects for to be referenced in an IAM policy for the instance.  Each is a list of strings that reference infra related to the install | <pre>object({<br>    bucket_arns             = optional(list(string), [])<br>    kms_key_arns            = optional(list(string), [])<br>    secret_manager_arns     = optional(list(string), [])<br>    log_group_arn           = optional(string, "")<br>    log_forwarding_enabled  = optional(bool, true)<br>    role_name               = optional(string, "deployment-role")<br>    policy_name             = optional(string, "deployment-policy")<br>    ssm_enable              = optional(bool, false)<br>    custom_tbw_ecr_repo_arn = optional(string, "")<br>  })</pre> | n/a | yes |
| <a name="input_primary_log_group_name"></a> [primary\_log\_group\_name](#input\_primary\_log\_group\_name) | Name of the Cloud Watch Log Group to be used for TFE Logs. | `string` | n/a | yes |
| <a name="input_primary_permit_all_egress"></a> [primary\_permit\_all\_egress](#input\_primary\_permit\_all\_egress) | Whether broad (0.0.0.0/0) egress should be permitted on cluster nodes. If disabled, additional rules must be added to permit HTTP(S) and other necessary network access. | `bool` | n/a | yes |
| <a name="input_primary_private_subnets"></a> [primary\_private\_subnets](#input\_primary\_private\_subnets) | List of private subnet CIDR ranges to create in VPC. | `list(string)` | n/a | yes |
| <a name="input_primary_public_subnets"></a> [primary\_public\_subnets](#input\_primary\_public\_subnets) | List of public subnet CIDR ranges to create in VPC. | `list(string)` | n/a | yes |
| <a name="input_primary_vpc_cidr"></a> [primary\_vpc\_cidr](#input\_primary\_vpc\_cidr) | CIDR block for VPC. | `string` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | Name of the HashiCorp product that will consume this service (tfe, tfefdo, vault, consul, nomad, and boundary) | `string` | n/a | yes |
| <a name="input_region_primary"></a> [region\_primary](#input\_region\_primary) | AWS Primary Region | `string` | n/a | yes |
| <a name="input_region_secondary"></a> [region\_secondary](#input\_region\_secondary) | AWS Secondary Region | `string` | n/a | yes |
| <a name="input_secondary_log_group_name"></a> [secondary\_log\_group\_name](#input\_secondary\_log\_group\_name) | Name of the Cloud Watch Log Group to be used for TFE Logs. | `string` | n/a | yes |
| <a name="input_secondary_permit_all_egress"></a> [secondary\_permit\_all\_egress](#input\_secondary\_permit\_all\_egress) | Whether broad (0.0.0.0/0) egress should be permitted on cluster nodes. If disabled, additional rules must be added to permit HTTP(S) and other necessary network access. | `bool` | n/a | yes |
| <a name="input_secondary_private_subnets"></a> [secondary\_private\_subnets](#input\_secondary\_private\_subnets) | List of private subnet CIDR ranges to create in VPC. | `list(string)` | n/a | yes |
| <a name="input_secondary_public_subnets"></a> [secondary\_public\_subnets](#input\_secondary\_public\_subnets) | List of public subnet CIDR ranges to create in VPC. | `list(string)` | n/a | yes |
| <a name="input_secondary_vpc_cidr"></a> [secondary\_vpc\_cidr](#input\_secondary\_vpc\_cidr) | CIDR block for VPC. | `string` | n/a | yes |
| <a name="input_secretsmanager_secrets"></a> [secretsmanager\_secrets](#input\_secretsmanager\_secrets) | Object Map that contains various TFE secrets that will be created and stored in AWS Secrets Manager. | <pre>object({<br>    tfe = optional(object({<br>      license = optional(object({<br>        name        = optional(string, "tfe-license")<br>        description = optional(string, "License for TFE FDO")<br>        data        = optional(string, null)<br>        path        = optional(string, null)<br>      }))<br>      enc_password = optional(object({<br>        name        = optional(string, "enc-password")<br>        description = optional(string, "Encryption password used in the TFE installation")<br>        data        = optional(string, null)<br>        generate    = optional(bool, true)<br>      }))<br>      console_password = optional(object({<br>        name        = optional(string, "console-password")<br>        description = optional(string, "Console password used in the TFE installation")<br>        data        = optional(string, null)<br>        generate    = optional(bool, true)<br>      }))<br>    }))<br>    ca_certificate_bundle = optional(object({<br>      name        = optional(string, null)<br>      path        = optional(string, null)<br>      description = optional(string, "TFE BYO CA certificate bundle")<br>      data        = optional(string, null)<br>    }))<br>    cert_pem_secret = optional(object({<br>      name        = optional(string, null)<br>      path        = optional(string, null)<br>      description = optional(string, "TFE BYO PEM-encoded TLS certificate")<br>      data        = optional(string, null)<br>    }))<br>    cert_pem_private_key_secret = optional(object({<br>      name        = optional(string, null)<br>      path        = optional(string, null)<br>      description = optional(string, "TFE BYO PEM-encoded TLS private key")<br>      data        = optional(string, null)<br>    }))<br>    replicated_license = optional(object({<br>      name        = optional(string, "tfe-replicated-license")<br>      path        = optional(string, null)<br>      description = optional(string, "license")<br>      data        = optional(string, null)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_tfe_active_active"></a> [tfe\_active\_active](#input\_tfe\_active\_active) | Boolean that determines if the pre-requisites for an active active deployment of TFE will be deployed. | `bool` | n/a | yes |
| <a name="input_tfe_fdo_release_sequence"></a> [tfe\_fdo\_release\_sequence](#input\_tfe\_fdo\_release\_sequence) | TFE release sequence number to deploy. This is used to retrieve the correct container | `string` | n/a | yes |
| <a name="input_tfe_hostname"></a> [tfe\_hostname](#input\_tfe\_hostname) | Fully qualified domain name for the TFE instances to use. This is utilized as a string input so that the destroy operations will complete cleanly if you are tearing down a multi-site deployment. | `string` | n/a | yes |
| <a name="input_vpc_enable_ssm"></a> [vpc\_enable\_ssm](#input\_vpc\_enable\_ssm) | Boolean that when true will create a security group allowing port 443 to the private\_subnets within the VPC (if create\_vpc is true) | `bool` | n/a | yes |
| <a name="input_create_ssh_keypair"></a> [create\_ssh\_keypair](#input\_create\_ssh\_keypair) | Boolean to deploy TFE SSH key pair. This does not create the private key, it only creates the key pair with a provided public key. | `bool` | `false` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for the DB user. | `string` | `"tfe"` | no |
| <a name="input_lb_listener_details"></a> [lb\_listener\_details](#input\_lb\_listener\_details) | Configures the LB Listeners for TFE | <pre>object({<br>    tfe_api = optional(object({<br>      create      = optional(bool, true)<br>      port        = optional(number, 443)<br>      ssl_policy  = optional(string, "ELBSecurityPolicy-2016-08")<br>      action_type = optional(string, "forward")<br>    }), {})<br>    tfe_console = optional(object({<br>      create      = optional(bool, true)<br>      port        = optional(number, 8800)<br>      ssl_policy  = optional(string, "ELBSecurityPolicy-2016-08")<br>      action_type = optional(string, "forward")<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_lb_sg_rules_details"></a> [lb\_sg\_rules\_details](#input\_lb\_sg\_rules\_details) | Object map for various Security Group Rules as pertains to the Load Balancer for TFE | <pre>object({<br>    tfe_api_ingress = optional(object({<br>      type        = optional(string, "ingress")<br>      create      = optional(bool, true)<br>      from_port   = optional(string, "443")<br>      to_port     = optional(string, "443")<br>      protocol    = optional(string, "tcp")<br>      cidr_blocks = optional(list(string), [])<br>      description = optional(string, "Allow 443 traffic inbound for TFE")<br>    }), {})<br>    tfe_console_ingress = optional(object({<br>      type        = optional(string, "ingress")<br>      create      = optional(bool, true)<br>      from_port   = optional(string, "8800")<br>      to_port     = optional(string, "8800")<br>      protocol    = optional(string, "tcp")<br>      cidr_blocks = optional(list(string), [])<br>      description = optional(string, "Allow 8800 traffic inbound for TFE")<br>    }), {})<br>    egress = optional(object({<br>      create      = optional(bool, true)<br>      type        = optional(string, "egress")<br>      from_port   = optional(string, "0")<br>      to_port     = optional(string, "0")<br>      protocol    = optional(string, "-1")<br>      cidr_blocks = optional(list(string), ["0.0.0.0/0"])<br>      description = optional(string, "Allow traffic outbound for TFE")<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_lb_target_groups"></a> [lb\_target\_groups](#input\_lb\_target\_groups) | Object map that creates the LB target groups for the enterprise products | <pre>object({<br>    tfe_api = optional(object({<br>      create               = optional(bool, true)<br>      description          = optional(string, "Target Group for TLS API/Web application traffic")<br>      name                 = optional(string, "tfe-tls-tg")<br>      deregistration_delay = optional(number, 60)<br>      port                 = optional(number, 443)<br>      protocol             = optional(string, "HTTPS")<br>      health_check = optional(object({<br>        enabled             = optional(bool, true)<br>        port                = optional(number, 443)<br>        healthy_threshold   = optional(number, 2)<br>        unhealthy_threshold = optional(number, 3)<br>        timeout             = optional(number, 5)<br>        interval            = optional(number, 15)<br>        matcher             = optional(string, "200")<br>        path                = optional(string, "/_health_check")<br>        protocol            = optional(string, "HTTPS")<br>      }), {})<br>    }), {})<br>    tfe_console = optional(object({<br>      create               = optional(bool, true)<br>      name                 = optional(string, "tfe-console-tg")<br>      description          = optional(string, "Target Group for TFE/Replicated web admin console traffic")<br>      deregistration_delay = optional(number, 60)<br>      port                 = optional(number, 8800)<br>      protocol             = optional(string, "HTTPS")<br>      health_check = optional(object({<br>        enabled             = optional(bool, true)<br>        port                = optional(number, 8800)<br>        healthy_threshold   = optional(number, 2)<br>        unhealthy_threshold = optional(number, 3)<br>        timeout             = optional(number, 5)<br>        interval            = optional(number, 15)<br>        matcher             = optional(string, "200-299")<br>        path                = optional(string, "/ping")<br>        protocol            = optional(string, "HTTPS")<br>      }), {})<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | Type of load balancer that will be provisioned as a part of the module execution (if specified). | `string` | `"application"` | no |
| <a name="input_log_forwarding_type"></a> [log\_forwarding\_type](#input\_log\_forwarding\_type) | Which type of log forwarding to configure. For any of these,`var.log_forwarding_enabled` must be set to `true`. For  S3, specify `s3` and supply a value for `var.s3_log_bucket_name`, for Cloudwatch specify `cloudwatch` and `var.cloudwatch_log_group_name`, for custom, specify `custom` and supply a valid fluentbit config in `var.custom_fluent_bit_config`. | `string` | `"s3"` | no |
| <a name="input_primary_common_tags"></a> [primary\_common\_tags](#input\_primary\_common\_tags) | Map of common tags for all taggable AWS resources. | `map(string)` | `{}` | no |
| <a name="input_primary_log_forwarding_enabled"></a> [primary\_log\_forwarding\_enabled](#input\_primary\_log\_forwarding\_enabled) | Boolean that when true, will enable log forwarding to Cloud Watch | `bool` | `true` | no |
| <a name="input_primary_route53_failover_record"></a> [primary\_route53\_failover\_record](#input\_primary\_route53\_failover\_record) | If set, creates a Route53 failover record.  Ensure that the record name is the same between both modules.  Also, the Record ID needs to be unique per module | <pre>object({<br>    create              = optional(bool, true)<br>    set_id              = optional(string, "fso1")<br>    lb_failover_primary = optional(bool, true)<br>    record_name         = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | Route 53 public zone name | `string` | `""` | no |
| <a name="input_secondary_common_tags"></a> [secondary\_common\_tags](#input\_secondary\_common\_tags) | Map of common tags for all taggable AWS resources. | `map(string)` | `{}` | no |
| <a name="input_secondary_log_forwarding_enabled"></a> [secondary\_log\_forwarding\_enabled](#input\_secondary\_log\_forwarding\_enabled) | Boolean that when true, will enable log forwarding to Cloud Watch | `bool` | `true` | no |
| <a name="input_secondary_route53_failover_record"></a> [secondary\_route53\_failover\_record](#input\_secondary\_route53\_failover\_record) | If set, creates a Route53 failover record.  Ensure that the record name is the same between both modules.  Also, the Record ID needs to be unique per module | <pre>object({<br>    create              = optional(bool, true)<br>    set_id              = optional(string, "fso1")<br>    lb_failover_primary = optional(bool, true)<br>    record_name         = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_secondary_s3_buckets"></a> [secondary\_s3\_buckets](#input\_secondary\_s3\_buckets) | Object Map that contains the configuration for the S3 logging and bootstrap bucket configuration. | <pre>object({<br>    bootstrap = optional(object({<br>      create                              = optional(bool, true)<br>      bucket_name                         = optional(string, "tfe-bootstrap-bucket")<br>      description                         = optional(string, "Bootstrap bucket for the TFE instances and install")<br>      versioning                          = optional(bool, true)<br>      force_destroy                       = optional(bool, false)<br>      replication                         = optional(bool)<br>      replication_destination_bucket_arn  = optional(string)<br>      replication_destination_kms_key_arn = optional(string)<br>      replication_destination_region      = optional(string)<br>      encrypt                             = optional(bool, true)<br>      bucket_key_enabled                  = optional(bool, true)<br>      kms_key_arn                         = optional(string)<br>      sse_s3_managed_key                  = optional(bool, false)<br>      is_secondary_region                 = optional(bool, false)<br>    }), {})<br>    tfe_app = optional(object({<br>      create                              = optional(bool, true)<br>      bucket_name                         = optional(string, "tfe-app-bucket")<br>      description                         = optional(string, "Object store for TFE")<br>      versioning                          = optional(bool, true)<br>      force_destroy                       = optional(bool, false)<br>      replication                         = optional(bool)<br>      replication_destination_bucket_arn  = optional(string)<br>      replication_destination_kms_key_arn = optional(string)<br>      replication_destination_region      = optional(string)<br>      encrypt                             = optional(bool, true)<br>      bucket_key_enabled                  = optional(bool, true)<br>      kms_key_arn                         = optional(string)<br>      sse_s3_managed_key                  = optional(bool, false)<br>      is_secondary_region                 = optional(bool, false)<br>    }), {})<br>    logging = optional(object({<br>      create                              = optional(bool, true)<br>      bucket_name                         = optional(string, "hashicorp-log-bucket")<br>      versioning                          = optional(bool, false)<br>      force_destroy                       = optional(bool, false)<br>      replication                         = optional(bool, false)<br>      replication_destination_bucket_arn  = optional(string)<br>      replication_destination_kms_key_arn = optional(string)<br>      replication_destination_region      = optional(string)<br>      encrypt                             = optional(bool, true)<br>      bucket_key_enabled                  = optional(bool, true)<br>      kms_key_arn                         = optional(string)<br>      sse_s3_managed_key                  = optional(bool, false)<br>      lifecycle_enabled                   = optional(bool, true)<br>      lifecycle_expiration_days           = optional(number, 7)<br>      is_secondary_region                 = optional(bool, false)<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Public key material for TFE SSH Key Pair. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_acm_certificate_arn"></a> [primary\_acm\_certificate\_arn](#output\_primary\_acm\_certificate\_arn) | The ARN of the certificate |
| <a name="output_primary_acm_certificate_status"></a> [primary\_acm\_certificate\_status](#output\_primary\_acm\_certificate\_status) | Status of the certificate |
| <a name="output_primary_acm_distinct_domain_names"></a> [primary\_acm\_distinct\_domain\_names](#output\_primary\_acm\_distinct\_domain\_names) | List of distinct domains names used for the validation |
| <a name="output_primary_acm_validation_domains"></a> [primary\_acm\_validation\_domains](#output\_primary\_acm\_validation\_domains) | List of distinct domain validation options. This is useful if subject alternative names contain wildcards |
| <a name="output_primary_acm_validation_route53_record_fqdns"></a> [primary\_acm\_validation\_route53\_record\_fqdns](#output\_primary\_acm\_validation\_route53\_record\_fqdns) | List of FQDNs built using the zone domain and name |
| <a name="output_primary_asg_hook_value"></a> [primary\_asg\_hook\_value](#output\_primary\_asg\_hook\_value) | Value for the `asg-hook` tag that will be attatched to the TFE instance in the other module. Use this value to ensure the lifecycle hook is updated during deployment. |
| <a name="output_primary_ca_certificate_bundle_secret_arn"></a> [primary\_ca\_certificate\_bundle\_secret\_arn](#output\_primary\_ca\_certificate\_bundle\_secret\_arn) | AWS Secrets Manager TFE BYO CA certificate secret ARN. |
| <a name="output_primary_cert_pem_private_key_secret_arn"></a> [primary\_cert\_pem\_private\_key\_secret\_arn](#output\_primary\_cert\_pem\_private\_key\_secret\_arn) | AWS Secrets Manager TFE BYO CA certificate private key secret ARN. |
| <a name="output_primary_cert_pem_secret_arn"></a> [primary\_cert\_pem\_secret\_arn](#output\_primary\_cert\_pem\_secret\_arn) | AWS Secrets Manager TFE BYO CA certificate private key secret ARN. |
| <a name="output_primary_cloudwatch_log_group_name"></a> [primary\_cloudwatch\_log\_group\_name](#output\_primary\_cloudwatch\_log\_group\_name) | AWS CloudWatch Log Group Name. |
| <a name="output_primary_db_additional_cluster_endpoints"></a> [primary\_db\_additional\_cluster\_endpoints](#output\_primary\_db\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_primary_db_cluster_arn"></a> [primary\_db\_cluster\_arn](#output\_primary\_db\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_primary_db_cluster_cloudwatch_log_groups"></a> [primary\_db\_cluster\_cloudwatch\_log\_groups](#output\_primary\_db\_cluster\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_primary_db_cluster_database_name"></a> [primary\_db\_cluster\_database\_name](#output\_primary\_db\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_primary_db_cluster_endpoint"></a> [primary\_db\_cluster\_endpoint](#output\_primary\_db\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_primary_db_cluster_engine_version_actual"></a> [primary\_db\_cluster\_engine\_version\_actual](#output\_primary\_db\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_primary_db_cluster_id"></a> [primary\_db\_cluster\_id](#output\_primary\_db\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_primary_db_cluster_instances"></a> [primary\_db\_cluster\_instances](#output\_primary\_db\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_primary_db_cluster_members"></a> [primary\_db\_cluster\_members](#output\_primary\_db\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_primary_db_cluster_port"></a> [primary\_db\_cluster\_port](#output\_primary\_db\_cluster\_port) | The database port |
| <a name="output_primary_db_cluster_reader_endpoint"></a> [primary\_db\_cluster\_reader\_endpoint](#output\_primary\_db\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_primary_db_cluster_resource_id"></a> [primary\_db\_cluster\_resource\_id](#output\_primary\_db\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_primary_db_cluster_role_associations"></a> [primary\_db\_cluster\_role\_associations](#output\_primary\_db\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_primary_db_enhanced_monitoring_iam_role_arn"></a> [primary\_db\_enhanced\_monitoring\_iam\_role\_arn](#output\_primary\_db\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_primary_db_enhanced_monitoring_iam_role_name"></a> [primary\_db\_enhanced\_monitoring\_iam\_role\_name](#output\_primary\_db\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_primary_db_enhanced_monitoring_iam_role_unique_id"></a> [primary\_db\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_primary\_db\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_primary_db_global_cluster_id"></a> [primary\_db\_global\_cluster\_id](#output\_primary\_db\_global\_cluster\_id) | ID of the global cluster that has been created (if specified.) |
| <a name="output_primary_db_password"></a> [primary\_db\_password](#output\_primary\_db\_password) | The database master password |
| <a name="output_primary_db_security_group_id"></a> [primary\_db\_security\_group\_id](#output\_primary\_db\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_primary_db_subnet_arns"></a> [primary\_db\_subnet\_arns](#output\_primary\_db\_subnet\_arns) | List of ARNs of database subnets |
| <a name="output_primary_db_subnet_group"></a> [primary\_db\_subnet\_group](#output\_primary\_db\_subnet\_group) | ID of database subnet group |
| <a name="output_primary_db_subnet_group_name"></a> [primary\_db\_subnet\_group\_name](#output\_primary\_db\_subnet\_group\_name) | Name of database subnet group |
| <a name="output_primary_db_subnet_ids"></a> [primary\_db\_subnet\_ids](#output\_primary\_db\_subnet\_ids) | List of IDs of database subnets |
| <a name="output_primary_db_subnets_cidr_blocks"></a> [primary\_db\_subnets\_cidr\_blocks](#output\_primary\_db\_subnets\_cidr\_blocks) | List of cidr\_blocks of database subnets |
| <a name="output_primary_db_subnets_ipv6_cidr_blocks"></a> [primary\_db\_subnets\_ipv6\_cidr\_blocks](#output\_primary\_db\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of database subnets in an IPv6 enabled VPC |
| <a name="output_primary_db_username"></a> [primary\_db\_username](#output\_primary\_db\_username) | The database master username |
| <a name="output_primary_default_security_group_id"></a> [primary\_default\_security\_group\_id](#output\_primary\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_primary_iam_instance_profile"></a> [primary\_iam\_instance\_profile](#output\_primary\_iam\_instance\_profile) | ARN of IAM Instance Profile for TFE Instance Role |
| <a name="output_primary_iam_managed_policy_arn"></a> [primary\_iam\_managed\_policy\_arn](#output\_primary\_iam\_managed\_policy\_arn) | ARN of IAM Managed Policy for TFE Instance Role |
| <a name="output_primary_iam_managed_policy_name"></a> [primary\_iam\_managed\_policy\_name](#output\_primary\_iam\_managed\_policy\_name) | Name of IAM Managed Policy for TFE Instance Role |
| <a name="output_primary_iam_role_arn"></a> [primary\_iam\_role\_arn](#output\_primary\_iam\_role\_arn) | ARN of IAM Role in use by TFE Instances |
| <a name="output_primary_iam_role_name"></a> [primary\_iam\_role\_name](#output\_primary\_iam\_role\_name) | Name of IAM Role in use by TFE Instances |
| <a name="output_primary_kms_key_alias"></a> [primary\_kms\_key\_alias](#output\_primary\_kms\_key\_alias) | The KMS Key Alias |
| <a name="output_primary_kms_key_alias_arn"></a> [primary\_kms\_key\_alias\_arn](#output\_primary\_kms\_key\_alias\_arn) | The KMS Key Alias arn |
| <a name="output_primary_kms_key_arn"></a> [primary\_kms\_key\_arn](#output\_primary\_kms\_key\_arn) | The KMS key used to encrypt data. |
| <a name="output_primary_lb_arn"></a> [primary\_lb\_arn](#output\_primary\_lb\_arn) | The Resource Identifier of the LB |
| <a name="output_primary_lb_dns_name"></a> [primary\_lb\_dns\_name](#output\_primary\_lb\_dns\_name) | The DNS name created with the LB |
| <a name="output_primary_lb_internal"></a> [primary\_lb\_internal](#output\_primary\_lb\_internal) | Boolean value of the internal/external status of the LB.  Determines if the LB gets Elastic IPs assigned |
| <a name="output_primary_lb_name"></a> [primary\_lb\_name](#output\_primary\_lb\_name) | Name of the LB |
| <a name="output_primary_lb_security_group_ids"></a> [primary\_lb\_security\_group\_ids](#output\_primary\_lb\_security\_group\_ids) | List of security group IDs in use by the LB |
| <a name="output_primary_lb_tg_arns"></a> [primary\_lb\_tg\_arns](#output\_primary\_lb\_tg\_arns) | List of target group ARNs for LB |
| <a name="output_primary_lb_type"></a> [primary\_lb\_type](#output\_primary\_lb\_type) | Type of LB created (ALB or NLB) |
| <a name="output_primary_lb_zone_id"></a> [primary\_lb\_zone\_id](#output\_primary\_lb\_zone\_id) | The Zone ID of the LB |
| <a name="output_primary_private_route_table_ids"></a> [primary\_private\_route\_table\_ids](#output\_primary\_private\_route\_table\_ids) | List of IDs of private route tables |
| <a name="output_primary_private_subnet_arns"></a> [primary\_private\_subnet\_arns](#output\_primary\_private\_subnet\_arns) | List of ARNs of private subnets |
| <a name="output_primary_private_subnet_ids"></a> [primary\_private\_subnet\_ids](#output\_primary\_private\_subnet\_ids) | List of IDs of private subnets |
| <a name="output_primary_private_subnets_cidr_blocks"></a> [primary\_private\_subnets\_cidr\_blocks](#output\_primary\_private\_subnets\_cidr\_blocks) | List of cidr\_blocks of private subnets |
| <a name="output_primary_private_subnets_ipv6_cidr_blocks"></a> [primary\_private\_subnets\_ipv6\_cidr\_blocks](#output\_primary\_private\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of private subnets in an IPv6 enabled VPC |
| <a name="output_primary_public_route_table_ids"></a> [primary\_public\_route\_table\_ids](#output\_primary\_public\_route\_table\_ids) | List of IDs of public route tables |
| <a name="output_primary_public_subnet_arns"></a> [primary\_public\_subnet\_arns](#output\_primary\_public\_subnet\_arns) | List of ARNs of public subnets |
| <a name="output_primary_public_subnet_ids"></a> [primary\_public\_subnet\_ids](#output\_primary\_public\_subnet\_ids) | List of IDs of public subnets |
| <a name="output_primary_public_subnets_cidr_blocks"></a> [primary\_public\_subnets\_cidr\_blocks](#output\_primary\_public\_subnets\_cidr\_blocks) | List of cidr\_blocks of public subnets |
| <a name="output_primary_public_subnets_ipv6_cidr_blocks"></a> [primary\_public\_subnets\_ipv6\_cidr\_blocks](#output\_primary\_public\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of public subnets in an IPv6 enabled VPC |
| <a name="output_primary_region"></a> [primary\_region](#output\_primary\_region) | The AWS region where the resources have been created |
| <a name="output_primary_replicated_license_secret_arn"></a> [primary\_replicated\_license\_secret\_arn](#output\_primary\_replicated\_license\_secret\_arn) | AWS Secrets Manager license secret ARN. |
| <a name="output_primary_route53_failover_fqdn"></a> [primary\_route53\_failover\_fqdn](#output\_primary\_route53\_failover\_fqdn) | FQDN of failover LB Route53 record |
| <a name="output_primary_route53_failover_record_name"></a> [primary\_route53\_failover\_record\_name](#output\_primary\_route53\_failover\_record\_name) | Name of the failover LB Route53 record name |
| <a name="output_primary_route53_regional_fqdn"></a> [primary\_route53\_regional\_fqdn](#output\_primary\_route53\_regional\_fqdn) | FQDN of regional LB Route53 record |
| <a name="output_primary_route53_regional_record_name"></a> [primary\_route53\_regional\_record\_name](#output\_primary\_route53\_regional\_record\_name) | Name of the regional LB Route53 record name |
| <a name="output_primary_s3_bootstrap_bucket_arn"></a> [primary\_s3\_bootstrap\_bucket\_arn](#output\_primary\_s3\_bootstrap\_bucket\_arn) | ARN of S3 'bootstrap' bucket |
| <a name="output_primary_s3_bootstrap_bucket_name"></a> [primary\_s3\_bootstrap\_bucket\_name](#output\_primary\_s3\_bootstrap\_bucket\_name) | Name of S3 'bootstrap' bucket. |
| <a name="output_primary_s3_bootstrap_bucket_replication_policy"></a> [primary\_s3\_bootstrap\_bucket\_replication\_policy](#output\_primary\_s3\_bootstrap\_bucket\_replication\_policy) | Replication policy of the S3 'bootstrap' bucket. |
| <a name="output_primary_s3_bucket_arn_list"></a> [primary\_s3\_bucket\_arn\_list](#output\_primary\_s3\_bucket\_arn\_list) | A list of the ARNs for the buckets that have been configured |
| <a name="output_primary_s3_log_bucket_arn"></a> [primary\_s3\_log\_bucket\_arn](#output\_primary\_s3\_log\_bucket\_arn) | Name of S3 'logging' bucket. |
| <a name="output_primary_s3_log_bucket_name"></a> [primary\_s3\_log\_bucket\_name](#output\_primary\_s3\_log\_bucket\_name) | Name of S3 'logging' bucket. |
| <a name="output_primary_s3_log_bucket_replication_policy"></a> [primary\_s3\_log\_bucket\_replication\_policy](#output\_primary\_s3\_log\_bucket\_replication\_policy) | Replication policy of the S3 'logging' bucket. |
| <a name="output_primary_s3_replication_iam_role_arn"></a> [primary\_s3\_replication\_iam\_role\_arn](#output\_primary\_s3\_replication\_iam\_role\_arn) | ARN of IAM Role for S3 replication. |
| <a name="output_primary_s3_tfe_app_bucket_arn"></a> [primary\_s3\_tfe\_app\_bucket\_arn](#output\_primary\_s3\_tfe\_app\_bucket\_arn) | ARN of the S3 Terraform Enterprise Object Store bucket. |
| <a name="output_primary_s3_tfe_app_bucket_name"></a> [primary\_s3\_tfe\_app\_bucket\_name](#output\_primary\_s3\_tfe\_app\_bucket\_name) | Name of S3 S3 Terraform Enterprise Object Store bucket. |
| <a name="output_primary_s3_tfe_app_bucket_replication_policy"></a> [primary\_s3\_tfe\_app\_bucket\_replication\_policy](#output\_primary\_s3\_tfe\_app\_bucket\_replication\_policy) | Replication policy of the S3 Terraform Enterprise Object Store bucket. |
| <a name="output_primary_secret_arn_list"></a> [primary\_secret\_arn\_list](#output\_primary\_secret\_arn\_list) | A list of AWS Secrets Manager Arns produced by the module |
| <a name="output_primary_ssh_keypair_arn"></a> [primary\_ssh\_keypair\_arn](#output\_primary\_ssh\_keypair\_arn) | ARN of the keypair that was created (if specified). |
| <a name="output_primary_ssh_keypair_fingerprint"></a> [primary\_ssh\_keypair\_fingerprint](#output\_primary\_ssh\_keypair\_fingerprint) | Fingerprint of TFE SSH Key Pair. |
| <a name="output_primary_ssh_keypair_id"></a> [primary\_ssh\_keypair\_id](#output\_primary\_ssh\_keypair\_id) | ID of TFE SSH Key Pair. |
| <a name="output_primary_ssh_keypair_name"></a> [primary\_ssh\_keypair\_name](#output\_primary\_ssh\_keypair\_name) | Name of the keypair that was created (if specified). |
| <a name="output_primary_tfe_secrets_arn"></a> [primary\_tfe\_secrets\_arn](#output\_primary\_tfe\_secrets\_arn) | AWS Secrets Manager `tfe` secrets ARN. |
| <a name="output_primary_vpc_arn"></a> [primary\_vpc\_arn](#output\_primary\_vpc\_arn) | The ARN of the VPC |
| <a name="output_primary_vpc_cidr_block"></a> [primary\_vpc\_cidr\_block](#output\_primary\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_primary_vpc_id"></a> [primary\_vpc\_id](#output\_primary\_vpc\_id) | The ID of the VPC |
| <a name="output_secondary_acm_certificate_arn"></a> [secondary\_acm\_certificate\_arn](#output\_secondary\_acm\_certificate\_arn) | The ARN of the certificate |
| <a name="output_secondary_acm_certificate_status"></a> [secondary\_acm\_certificate\_status](#output\_secondary\_acm\_certificate\_status) | Status of the certificate |
| <a name="output_secondary_acm_distinct_domain_names"></a> [secondary\_acm\_distinct\_domain\_names](#output\_secondary\_acm\_distinct\_domain\_names) | List of distinct domains names used for the validation |
| <a name="output_secondary_acm_validation_domains"></a> [secondary\_acm\_validation\_domains](#output\_secondary\_acm\_validation\_domains) | List of distinct domain validation options. This is useful if subject alternative names contain wildcards |
| <a name="output_secondary_acm_validation_route53_record_fqdns"></a> [secondary\_acm\_validation\_route53\_record\_fqdns](#output\_secondary\_acm\_validation\_route53\_record\_fqdns) | List of FQDNs built using the zone domain and name |
| <a name="output_secondary_asg_hook_value"></a> [secondary\_asg\_hook\_value](#output\_secondary\_asg\_hook\_value) | Value for the `asg-hook` tag that will be attatched to the TFE instance in the other module. Use this value to ensure the lifecycle hook is updated during deployment. |
| <a name="output_secondary_ca_certificate_bundle_secret_arn"></a> [secondary\_ca\_certificate\_bundle\_secret\_arn](#output\_secondary\_ca\_certificate\_bundle\_secret\_arn) | AWS Secrets Manager TFE BYO CA certificate secret ARN. |
| <a name="output_secondary_cert_pem_private_key_secret_arn"></a> [secondary\_cert\_pem\_private\_key\_secret\_arn](#output\_secondary\_cert\_pem\_private\_key\_secret\_arn) | AWS Secrets Manager TFE BYO CA certificate private key secret ARN. |
| <a name="output_secondary_cert_pem_secret_arn"></a> [secondary\_cert\_pem\_secret\_arn](#output\_secondary\_cert\_pem\_secret\_arn) | AWS Secrets Manager TFE BYO CA certificate private key secret ARN. |
| <a name="output_secondary_cloudwatch_log_group_name"></a> [secondary\_cloudwatch\_log\_group\_name](#output\_secondary\_cloudwatch\_log\_group\_name) | AWS CloudWatch Log Group Name. |
| <a name="output_secondary_db_additional_cluster_endpoints"></a> [secondary\_db\_additional\_cluster\_endpoints](#output\_secondary\_db\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_secondary_db_cluster_arn"></a> [secondary\_db\_cluster\_arn](#output\_secondary\_db\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_secondary_db_cluster_cloudwatch_log_groups"></a> [secondary\_db\_cluster\_cloudwatch\_log\_groups](#output\_secondary\_db\_cluster\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_secondary_db_cluster_database_name"></a> [secondary\_db\_cluster\_database\_name](#output\_secondary\_db\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_secondary_db_cluster_endpoint"></a> [secondary\_db\_cluster\_endpoint](#output\_secondary\_db\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_secondary_db_cluster_engine_version_actual"></a> [secondary\_db\_cluster\_engine\_version\_actual](#output\_secondary\_db\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_secondary_db_cluster_id"></a> [secondary\_db\_cluster\_id](#output\_secondary\_db\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_secondary_db_cluster_instances"></a> [secondary\_db\_cluster\_instances](#output\_secondary\_db\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_secondary_db_cluster_members"></a> [secondary\_db\_cluster\_members](#output\_secondary\_db\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_secondary_db_cluster_port"></a> [secondary\_db\_cluster\_port](#output\_secondary\_db\_cluster\_port) | The database port |
| <a name="output_secondary_db_cluster_reader_endpoint"></a> [secondary\_db\_cluster\_reader\_endpoint](#output\_secondary\_db\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_secondary_db_cluster_resource_id"></a> [secondary\_db\_cluster\_resource\_id](#output\_secondary\_db\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_secondary_db_cluster_role_associations"></a> [secondary\_db\_cluster\_role\_associations](#output\_secondary\_db\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_secondary_db_enhanced_monitoring_iam_role_arn"></a> [secondary\_db\_enhanced\_monitoring\_iam\_role\_arn](#output\_secondary\_db\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_secondary_db_enhanced_monitoring_iam_role_name"></a> [secondary\_db\_enhanced\_monitoring\_iam\_role\_name](#output\_secondary\_db\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_secondary_db_enhanced_monitoring_iam_role_unique_id"></a> [secondary\_db\_enhanced\_monitoring\_iam\_role\_unique\_id](#output\_secondary\_db\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_secondary_db_global_cluster_id"></a> [secondary\_db\_global\_cluster\_id](#output\_secondary\_db\_global\_cluster\_id) | ID of the global cluster that has been created (if specified.) |
| <a name="output_secondary_db_password"></a> [secondary\_db\_password](#output\_secondary\_db\_password) | The database master password |
| <a name="output_secondary_db_security_group_id"></a> [secondary\_db\_security\_group\_id](#output\_secondary\_db\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_secondary_db_subnet_arns"></a> [secondary\_db\_subnet\_arns](#output\_secondary\_db\_subnet\_arns) | List of ARNs of database subnets |
| <a name="output_secondary_db_subnet_group"></a> [secondary\_db\_subnet\_group](#output\_secondary\_db\_subnet\_group) | ID of database subnet group |
| <a name="output_secondary_db_subnet_group_name"></a> [secondary\_db\_subnet\_group\_name](#output\_secondary\_db\_subnet\_group\_name) | Name of database subnet group |
| <a name="output_secondary_db_subnet_ids"></a> [secondary\_db\_subnet\_ids](#output\_secondary\_db\_subnet\_ids) | List of IDs of database subnets |
| <a name="output_secondary_db_subnets_cidr_blocks"></a> [secondary\_db\_subnets\_cidr\_blocks](#output\_secondary\_db\_subnets\_cidr\_blocks) | List of cidr\_blocks of database subnets |
| <a name="output_secondary_db_subnets_ipv6_cidr_blocks"></a> [secondary\_db\_subnets\_ipv6\_cidr\_blocks](#output\_secondary\_db\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of database subnets in an IPv6 enabled VPC |
| <a name="output_secondary_db_username"></a> [secondary\_db\_username](#output\_secondary\_db\_username) | The database master username |
| <a name="output_secondary_default_security_group_id"></a> [secondary\_default\_security\_group\_id](#output\_secondary\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation |
| <a name="output_secondary_iam_instance_profile"></a> [secondary\_iam\_instance\_profile](#output\_secondary\_iam\_instance\_profile) | ARN of IAM Instance Profile for TFE Instance Role |
| <a name="output_secondary_iam_managed_policy_arn"></a> [secondary\_iam\_managed\_policy\_arn](#output\_secondary\_iam\_managed\_policy\_arn) | ARN of IAM Managed Policy for TFE Instance Role |
| <a name="output_secondary_iam_managed_policy_name"></a> [secondary\_iam\_managed\_policy\_name](#output\_secondary\_iam\_managed\_policy\_name) | Name of IAM Managed Policy for TFE Instance Role |
| <a name="output_secondary_iam_role_arn"></a> [secondary\_iam\_role\_arn](#output\_secondary\_iam\_role\_arn) | ARN of IAM Role in use by TFE Instances |
| <a name="output_secondary_iam_role_name"></a> [secondary\_iam\_role\_name](#output\_secondary\_iam\_role\_name) | Name of IAM Role in use by TFE Instances |
| <a name="output_secondary_kms_key_alias"></a> [secondary\_kms\_key\_alias](#output\_secondary\_kms\_key\_alias) | The KMS Key Alias |
| <a name="output_secondary_kms_key_alias_arn"></a> [secondary\_kms\_key\_alias\_arn](#output\_secondary\_kms\_key\_alias\_arn) | The KMS Key Alias arn |
| <a name="output_secondary_kms_key_arn"></a> [secondary\_kms\_key\_arn](#output\_secondary\_kms\_key\_arn) | The KMS key used to encrypt data. |
| <a name="output_secondary_lb_arn"></a> [secondary\_lb\_arn](#output\_secondary\_lb\_arn) | The Resource Identifier of the LB |
| <a name="output_secondary_lb_dns_name"></a> [secondary\_lb\_dns\_name](#output\_secondary\_lb\_dns\_name) | The DNS name created with the LB |
| <a name="output_secondary_lb_internal"></a> [secondary\_lb\_internal](#output\_secondary\_lb\_internal) | Boolean value of the internal/external status of the LB.  Determines if the LB gets Elastic IPs assigned |
| <a name="output_secondary_lb_name"></a> [secondary\_lb\_name](#output\_secondary\_lb\_name) | Name of the LB |
| <a name="output_secondary_lb_security_group_ids"></a> [secondary\_lb\_security\_group\_ids](#output\_secondary\_lb\_security\_group\_ids) | List of security group IDs in use by the LB |
| <a name="output_secondary_lb_tg_arns"></a> [secondary\_lb\_tg\_arns](#output\_secondary\_lb\_tg\_arns) | List of target group ARNs for LB |
| <a name="output_secondary_lb_type"></a> [secondary\_lb\_type](#output\_secondary\_lb\_type) | Type of LB created (ALB or NLB) |
| <a name="output_secondary_lb_zone_id"></a> [secondary\_lb\_zone\_id](#output\_secondary\_lb\_zone\_id) | The Zone ID of the LB |
| <a name="output_secondary_private_route_table_ids"></a> [secondary\_private\_route\_table\_ids](#output\_secondary\_private\_route\_table\_ids) | List of IDs of private route tables |
| <a name="output_secondary_private_subnet_arns"></a> [secondary\_private\_subnet\_arns](#output\_secondary\_private\_subnet\_arns) | List of ARNs of private subnets |
| <a name="output_secondary_private_subnet_ids"></a> [secondary\_private\_subnet\_ids](#output\_secondary\_private\_subnet\_ids) | List of IDs of private subnets |
| <a name="output_secondary_private_subnets_cidr_blocks"></a> [secondary\_private\_subnets\_cidr\_blocks](#output\_secondary\_private\_subnets\_cidr\_blocks) | List of cidr\_blocks of private subnets |
| <a name="output_secondary_private_subnets_ipv6_cidr_blocks"></a> [secondary\_private\_subnets\_ipv6\_cidr\_blocks](#output\_secondary\_private\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of private subnets in an IPv6 enabled VPC |
| <a name="output_secondary_public_route_table_ids"></a> [secondary\_public\_route\_table\_ids](#output\_secondary\_public\_route\_table\_ids) | List of IDs of public route tables |
| <a name="output_secondary_public_subnet_arns"></a> [secondary\_public\_subnet\_arns](#output\_secondary\_public\_subnet\_arns) | List of ARNs of public subnets |
| <a name="output_secondary_public_subnet_ids"></a> [secondary\_public\_subnet\_ids](#output\_secondary\_public\_subnet\_ids) | List of IDs of public subnets |
| <a name="output_secondary_public_subnets_cidr_blocks"></a> [secondary\_public\_subnets\_cidr\_blocks](#output\_secondary\_public\_subnets\_cidr\_blocks) | List of cidr\_blocks of public subnets |
| <a name="output_secondary_public_subnets_ipv6_cidr_blocks"></a> [secondary\_public\_subnets\_ipv6\_cidr\_blocks](#output\_secondary\_public\_subnets\_ipv6\_cidr\_blocks) | List of IPv6 cidr\_blocks of public subnets in an IPv6 enabled VPC |
| <a name="output_secondary_region"></a> [secondary\_region](#output\_secondary\_region) | The AWS region where the resources have been created |
| <a name="output_secondary_replicated_license_secret_arn"></a> [secondary\_replicated\_license\_secret\_arn](#output\_secondary\_replicated\_license\_secret\_arn) | AWS Secrets Manager license secret ARN. |
| <a name="output_secondary_route53_failover_fqdn"></a> [secondary\_route53\_failover\_fqdn](#output\_secondary\_route53\_failover\_fqdn) | FQDN of failover LB Route53 record |
| <a name="output_secondary_route53_failover_record_name"></a> [secondary\_route53\_failover\_record\_name](#output\_secondary\_route53\_failover\_record\_name) | Name of the failover LB Route53 record name |
| <a name="output_secondary_route53_regional_fqdn"></a> [secondary\_route53\_regional\_fqdn](#output\_secondary\_route53\_regional\_fqdn) | FQDN of regional LB Route53 record |
| <a name="output_secondary_route53_regional_record_name"></a> [secondary\_route53\_regional\_record\_name](#output\_secondary\_route53\_regional\_record\_name) | Name of the regional LB Route53 record name |
| <a name="output_secondary_s3_bootstrap_bucket_arn"></a> [secondary\_s3\_bootstrap\_bucket\_arn](#output\_secondary\_s3\_bootstrap\_bucket\_arn) | ARN of S3 'bootstrap' bucket |
| <a name="output_secondary_s3_bootstrap_bucket_name"></a> [secondary\_s3\_bootstrap\_bucket\_name](#output\_secondary\_s3\_bootstrap\_bucket\_name) | Name of S3 'bootstrap' bucket. |
| <a name="output_secondary_s3_bootstrap_bucket_replication_policy"></a> [secondary\_s3\_bootstrap\_bucket\_replication\_policy](#output\_secondary\_s3\_bootstrap\_bucket\_replication\_policy) | Replication policy of the S3 'bootstrap' bucket. |
| <a name="output_secondary_s3_bucket_arn_list"></a> [secondary\_s3\_bucket\_arn\_list](#output\_secondary\_s3\_bucket\_arn\_list) | A list of the ARNs for the buckets that have been configured |
| <a name="output_secondary_s3_log_bucket_arn"></a> [secondary\_s3\_log\_bucket\_arn](#output\_secondary\_s3\_log\_bucket\_arn) | Name of S3 'logging' bucket. |
| <a name="output_secondary_s3_log_bucket_name"></a> [secondary\_s3\_log\_bucket\_name](#output\_secondary\_s3\_log\_bucket\_name) | Name of S3 'logging' bucket. |
| <a name="output_secondary_s3_log_bucket_replication_policy"></a> [secondary\_s3\_log\_bucket\_replication\_policy](#output\_secondary\_s3\_log\_bucket\_replication\_policy) | Replication policy of the S3 'logging' bucket. |
| <a name="output_secondary_s3_replication_iam_role_arn"></a> [secondary\_s3\_replication\_iam\_role\_arn](#output\_secondary\_s3\_replication\_iam\_role\_arn) | ARN of IAM Role for S3 replication. |
| <a name="output_secondary_s3_tfe_app_bucket_arn"></a> [secondary\_s3\_tfe\_app\_bucket\_arn](#output\_secondary\_s3\_tfe\_app\_bucket\_arn) | ARN of the S3 Terraform Enterprise Object Store bucket. |
| <a name="output_secondary_s3_tfe_app_bucket_name"></a> [secondary\_s3\_tfe\_app\_bucket\_name](#output\_secondary\_s3\_tfe\_app\_bucket\_name) | Name of S3 S3 Terraform Enterprise Object Store bucket. |
| <a name="output_secondary_s3_tfe_app_bucket_replication_policy"></a> [secondary\_s3\_tfe\_app\_bucket\_replication\_policy](#output\_secondary\_s3\_tfe\_app\_bucket\_replication\_policy) | Replication policy of the S3 Terraform Enterprise Object Store bucket. |
| <a name="output_secondary_secret_arn_list"></a> [secondary\_secret\_arn\_list](#output\_secondary\_secret\_arn\_list) | A list of AWS Secrets Manager Arns produced by the module |
| <a name="output_secondary_ssh_keypair_arn"></a> [secondary\_ssh\_keypair\_arn](#output\_secondary\_ssh\_keypair\_arn) | ARN of the keypair that was created (if specified). |
| <a name="output_secondary_ssh_keypair_fingerprint"></a> [secondary\_ssh\_keypair\_fingerprint](#output\_secondary\_ssh\_keypair\_fingerprint) | Fingerprint of TFE SSH Key Pair. |
| <a name="output_secondary_ssh_keypair_id"></a> [secondary\_ssh\_keypair\_id](#output\_secondary\_ssh\_keypair\_id) | ID of TFE SSH Key Pair. |
| <a name="output_secondary_ssh_keypair_name"></a> [secondary\_ssh\_keypair\_name](#output\_secondary\_ssh\_keypair\_name) | Name of the keypair that was created (if specified). |
| <a name="output_secondary_tfe_secrets_arn"></a> [secondary\_tfe\_secrets\_arn](#output\_secondary\_tfe\_secrets\_arn) | AWS Secrets Manager `tfe` secrets ARN. |
| <a name="output_secondary_vpc_arn"></a> [secondary\_vpc\_arn](#output\_secondary\_vpc\_arn) | The ARN of the VPC |
| <a name="output_secondary_vpc_cidr_block"></a> [secondary\_vpc\_cidr\_block](#output\_secondary\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_secondary_vpc_id"></a> [secondary\_vpc\_id](#output\_secondary\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->
