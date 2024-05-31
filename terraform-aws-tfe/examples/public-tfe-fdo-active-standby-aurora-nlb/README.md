# Public TFE (Flexible Deployment Option) Terraform Enterprise Active-Standby with an NLB example

This module is an example of utilizing the `terraform-aws-tfe` module as part of the deployment.

## Description

This module showcases an example of utilizing the root module of this repository to build out the following high level components for a TFE **active-standby** deployment inside of AWS in **multiple regions**:  

**Root Module**  
-  AWS Auto Scaling Group
-  AWS Auto Scaling Lifecycle hook
-  AWS Launch Template for ASG
-  AWS Security Group for EC2
-  AWS Security Group rules for EC2

## Getting Started

### Dependencies

* Terraform or Terraform Cloud for seeding

### Executing program

Modify the `terraform.auto.tfvars.example` file with parameters pertinent to your environment and rename it to `terraform.auto.tfvars`.

Once this is updated, authenticate to AWS then run through the standard Terraform Workflow:  

``` hcl
terraform init
terraform plan
terraform apply
```
---

## Deployment of Prerequisite AWS Infrastructure  

Note that this module requires specific infrastructure to be available prior to launching.  This includes but is not limited to:

* AWS ECR Repository (if required)
* AWS Security Group for DB
* AWS Security Group rules for DB
* Load Balancer, Listeners, and Target Groups
* KMS Encryption Keys
* Log Groups for Terraform Enterprise
* PostgreSQL DB cluster
* DNS Record for TFE
* S3 buckets
* Secrets Manager Secrets (for License, TLS Certificate and Private Key, and Credentials)
* SSH KeyPair for Terraform Enterprise (if not using SSM)
* VPC Endpoints (if using Private Networking)
* VPC with internet access 
* EC2 Instance Profile with access to:  
  * TFE S3 Bucket  
  * Secrets Manager TFE secrets  
  * TFE KMS Keys  
  * TFE Log Group  


 If you require building any or all of this infrastructure, please refer to our `terraform-aws-tfe-prerequisite` module.  This module is designed to create the necessary pre-requisite infrastructure within AWS to prepare for the deployment of TFE on EC2.  

An example of creating the required prerequisite infrastructure for TFE on AWS can be found within the [terraform-aws-tfe-prerequisites](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main) module under `/examples/`.  

---

## 📝 Note
Contained below is a table that outlines the input for the module and the corresponding output from the `terraform-aws-tfe-prerequisite` module. These outputs

| Deployment Module Input | Prerequisite Module Output |
| ------- | ----------- |
| `ssh_keypair_name` | `ssh_key_pair` |
| `vpc_id` | `vpc_id` |
| `tfe_hostname` | `route53_failover_fqdn` |
| `iam_instance_profile` | `iam_profile_name` |
| `kms_key_arn` | `kms_key_alias_arn` |
| `ec2_subnet_ids` | `private_subnet_ids` |
| `lb_tg_arns` | `lb_tg_arns` |
| `lb_type` | `lb_type` |
| `s3_app_bucket_name` | `s3_tfe_app_bucket_name` |
| `s3_log_bucket_name` | `s3_log_bucket_name` |
| `cloudwatch_log_group_name` | `cloudwatch_log_group_name` |
| `tfe_secrets_arn` | `tfe_secrets_arn` |
| `tfe_cert_secret_arn` | `cert_pem_secret_arn` |
| `tfe_privkey_secret_arn` | `cert_pem_private_key_secret_arn` |
| `ca_bundle_secret_arn` | `ca_certificate_bundle_secret_arn` |
| `db_username` | `db_username` |
| `db_password` | `db_password` |
| `db_database_name` | `db_cluster_database_name` |
| `db_cluster_endpoint` | `db_cluster_endpoint` |
| `asg_hook_value` | `asg_hook_value` |
| `product` | `N/A` |
| `asg_min_size` | `N/A` |
| `asg_max_size` | `N/A` |
| `asg_instance_count` | `N/A` |
| `common_tags` | `N/A` |
| `permit_all_egress` | `N/A` |
| `tfe_fdo_release_sequence` | `N/A` |
| `friendly_name_prefix` | `N/A` |
| `enable_active_active` | `N/A` |
| `log_forwarding_enabled` | `N/A` |
| `log_forwarding_type` | `N/A` |

---

## Failover Testing steps

>**📝 Note**
>
>This assumes you have already deployed the example. We are mimicing a controlled failover as a part of the first portion and a DB failing over without TFE being aware in the second half. This assumes you have already deployed the example. We are mimicing a controlled failover as a part of the first portion and a DB failing over without TFE being aware in the second half. The replication policies currently only replicated to the secondary site but don't replicate back. If you need to replicated the data in S3 back, Add a replication policy to replicate the data back to your primary region.

1. Change the `asg_instance_count = 1` to `0` for the `primary_tfe` module call.
2. `terraform apply`
3. Login to AWS and failover (Select Switchover in the UI) the aurora cluster to the secondary region.
4. Change `asg_instance_count = 0` to `1` for the `secondary_tfe` module call.
5. `terrform apply`
6. Retry the tfe url after about 7 minutes and make sure it works. Might need to use a different browser or incognito.
7. Login to AWS and failover (Select Switchover in the UI) the database cluster to mimic it dropping.
8. Change `asg_instance_count = 0` to `1` for `primary_tfe` and `asg_instance_count = 1` to `0` for the `secondary_tfe` module call.
9. `terraform apply`
10. Retry the tfe url after about 7 minutes once the run is complete. Ensure that the changes you made from the second site is present when you failed back.

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
| <a name="module_primary_tfe"></a> [primary\_tfe](#module\_primary\_tfe) | ../../ | n/a |
| <a name="module_secondary_tfe"></a> [secondary\_tfe](#module\_secondary\_tfe) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_database_name"></a> [db\_database\_name](#input\_db\_database\_name) | Name of database that will be created (if specified) or consumed by TFE. | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the DB user. | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for the DB user. | `string` | n/a | yes |
| <a name="input_friendly_name_prefix"></a> [friendly\_name\_prefix](#input\_friendly\_name\_prefix) | Friendly name prefix used for tagging and naming AWS resources. | `string` | n/a | yes |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | String indicating whether the load balancer deployed is an Application Load Balancer (alb) or Network Load Balancer (nlb). | `string` | n/a | yes |
| <a name="input_primary_asg_hook_value"></a> [primary\_asg\_hook\_value](#input\_primary\_asg\_hook\_value) | Value for the tag that is associated with the launch template. This is used for the lifecycle hook checkin. | `string` | n/a | yes |
| <a name="input_primary_ca_bundle_secret_arn"></a> [primary\_ca\_bundle\_secret\_arn](#input\_primary\_ca\_bundle\_secret\_arn) | ARN of AWS Secrets Manager secret for private/custom CA bundles. New lines must be replaced by `<br>` character prior to storing as a plaintext secret. | `string` | n/a | yes |
| <a name="input_primary_db_cluster_endpoint"></a> [primary\_db\_cluster\_endpoint](#input\_primary\_db\_cluster\_endpoint) | Writer endpoint for the database cluster. | `string` | n/a | yes |
| <a name="input_primary_ec2_subnet_ids"></a> [primary\_ec2\_subnet\_ids](#input\_primary\_ec2\_subnet\_ids) | List of subnet IDs to use for the EC2 instance. Private subnets is the best practice. | `list(string)` | n/a | yes |
| <a name="input_primary_iam_profile_name"></a> [primary\_iam\_profile\_name](#input\_primary\_iam\_profile\_name) | Name of AWS IAM Instance Profile for TFE EC2 Instance | `string` | n/a | yes |
| <a name="input_primary_kms_key_arn"></a> [primary\_kms\_key\_arn](#input\_primary\_kms\_key\_arn) | ARN of KMS key to encrypt TFE RDS, S3, EBS, and Redis resources. | `string` | n/a | yes |
| <a name="input_primary_lb_tg_arns"></a> [primary\_lb\_tg\_arns](#input\_primary\_lb\_tg\_arns) | List of Target Group ARNs associated with the TFE Load Balancer | `list(any)` | n/a | yes |
| <a name="input_primary_permit_all_egress"></a> [primary\_permit\_all\_egress](#input\_primary\_permit\_all\_egress) | Whether broad (0.0.0.0/0) egress should be permitted on cluster nodes. If disabled, additional rules must be added to permit HTTP(S) and other necessary network access. | `bool` | n/a | yes |
| <a name="input_primary_region"></a> [primary\_region](#input\_primary\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_primary_s3_app_bucket_name"></a> [primary\_s3\_app\_bucket\_name](#input\_primary\_s3\_app\_bucket\_name) | Name of S3 Terraform Enterprise Object Store bucket. | `string` | n/a | yes |
| <a name="input_primary_tfe_cert_secret_arn"></a> [primary\_tfe\_cert\_secret\_arn](#input\_primary\_tfe\_cert\_secret\_arn) | ARN of AWS Secrets Manager secret for TFE server certificate in PEM format. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored. | `string` | n/a | yes |
| <a name="input_primary_tfe_hostname"></a> [primary\_tfe\_hostname](#input\_primary\_tfe\_hostname) | FQDN of the TFE deployment. | `string` | n/a | yes |
| <a name="input_primary_tfe_privkey_secret_arn"></a> [primary\_tfe\_privkey\_secret\_arn](#input\_primary\_tfe\_privkey\_secret\_arn) | ARN of AWS Secrets Manager secret for TFE private key in PEM format and base64 encoded. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored. | `string` | n/a | yes |
| <a name="input_primary_tfe_secrets_arn"></a> [primary\_tfe\_secrets\_arn](#input\_primary\_tfe\_secrets\_arn) | ARN of the secret in AWS Secrets Manager that contains all of the TFE secrets | `string` | n/a | yes |
| <a name="input_primary_vpc_id"></a> [primary\_vpc\_id](#input\_primary\_vpc\_id) | VPC ID that TFE will be deployed into. | `string` | n/a | yes |
| <a name="input_secondary_asg_hook_value"></a> [secondary\_asg\_hook\_value](#input\_secondary\_asg\_hook\_value) | Value for the tag that is associated with the launch template. This is used for the lifecycle hook checkin. | `string` | n/a | yes |
| <a name="input_secondary_ca_bundle_secret_arn"></a> [secondary\_ca\_bundle\_secret\_arn](#input\_secondary\_ca\_bundle\_secret\_arn) | ARN of AWS Secrets Manager secret for private/custom CA bundles. New lines must be replaced by `<br>` character prior to storing as a plaintext secret. | `string` | n/a | yes |
| <a name="input_secondary_db_cluster_endpoint"></a> [secondary\_db\_cluster\_endpoint](#input\_secondary\_db\_cluster\_endpoint) | Writer endpoint for the database cluster. | `string` | n/a | yes |
| <a name="input_secondary_ec2_subnet_ids"></a> [secondary\_ec2\_subnet\_ids](#input\_secondary\_ec2\_subnet\_ids) | List of subnet IDs to use for the EC2 instance. Private subnets is the best practice. | `list(string)` | n/a | yes |
| <a name="input_secondary_iam_profile_name"></a> [secondary\_iam\_profile\_name](#input\_secondary\_iam\_profile\_name) | Name of AWS IAM Instance Profile for TFE EC2 Instance | `string` | n/a | yes |
| <a name="input_secondary_kms_key_arn"></a> [secondary\_kms\_key\_arn](#input\_secondary\_kms\_key\_arn) | ARN of KMS key to encrypt TFE RDS, S3, EBS, and Redis resources. | `string` | n/a | yes |
| <a name="input_secondary_lb_tg_arns"></a> [secondary\_lb\_tg\_arns](#input\_secondary\_lb\_tg\_arns) | List of Target Group ARNs associated with the TFE Load Balancer | `list(any)` | n/a | yes |
| <a name="input_secondary_permit_all_egress"></a> [secondary\_permit\_all\_egress](#input\_secondary\_permit\_all\_egress) | Whether broad (0.0.0.0/0) egress should be permitted on cluster nodes. If disabled, additional rules must be added to permit HTTP(S) and other necessary network access. | `bool` | n/a | yes |
| <a name="input_secondary_region"></a> [secondary\_region](#input\_secondary\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_secondary_s3_app_bucket_name"></a> [secondary\_s3\_app\_bucket\_name](#input\_secondary\_s3\_app\_bucket\_name) | Name of S3 Terraform Enterprise Object Store bucket. | `string` | n/a | yes |
| <a name="input_secondary_tfe_cert_secret_arn"></a> [secondary\_tfe\_cert\_secret\_arn](#input\_secondary\_tfe\_cert\_secret\_arn) | ARN of AWS Secrets Manager secret for TFE server certificate in PEM format. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored. | `string` | n/a | yes |
| <a name="input_secondary_tfe_hostname"></a> [secondary\_tfe\_hostname](#input\_secondary\_tfe\_hostname) | FQDN of the TFE deployment. | `string` | n/a | yes |
| <a name="input_secondary_tfe_privkey_secret_arn"></a> [secondary\_tfe\_privkey\_secret\_arn](#input\_secondary\_tfe\_privkey\_secret\_arn) | ARN of AWS Secrets Manager secret for TFE private key in PEM format and base64 encoded. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored. | `string` | n/a | yes |
| <a name="input_secondary_tfe_secrets_arn"></a> [secondary\_tfe\_secrets\_arn](#input\_secondary\_tfe\_secrets\_arn) | ARN of the secret in AWS Secrets Manager that contains all of the TFE secrets | `string` | n/a | yes |
| <a name="input_secondary_vpc_id"></a> [secondary\_vpc\_id](#input\_secondary\_vpc\_id) | VPC ID that TFE will be deployed into. | `string` | n/a | yes |
| <a name="input_tfe_active_active"></a> [tfe\_active\_active](#input\_tfe\_active\_active) | Boolean that determines if the pre-requisites for an active active deployment of TFE will be deployed. | `bool` | n/a | yes |
| <a name="input_tfe_fdo_release_sequence"></a> [tfe\_fdo\_release\_sequence](#input\_tfe\_fdo\_release\_sequence) | TFE release sequence number to deploy. This is used to retrieve the correct container | `string` | n/a | yes |
| <a name="input_log_forwarding_type"></a> [log\_forwarding\_type](#input\_log\_forwarding\_type) | Which type of log forwarding to configure. For any of these,`var.log_forwarding_enabled` must be set to `true`. For  S3, specify `s3` and supply a value for `var.s3_log_bucket_name`, for Cloudwatch specify `cloudwatch` and `var.cloudwatch_log_group_name`, for custom, specify `custom` and supply a valid fluentbit config in `var.custom_fluent_bit_config`. | `string` | `"s3"` | no |
| <a name="input_primary_cloudwatch_log_group_name"></a> [primary\_cloudwatch\_log\_group\_name](#input\_primary\_cloudwatch\_log\_group\_name) | Name of CloudWatch Log Group to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`. | `string` | `""` | no |
| <a name="input_primary_common_tags"></a> [primary\_common\_tags](#input\_primary\_common\_tags) | Map of common tags for all taggable AWS resources. | `map(string)` | `{}` | no |
| <a name="input_primary_log_forwarding_enabled"></a> [primary\_log\_forwarding\_enabled](#input\_primary\_log\_forwarding\_enabled) | Boolean to enable TFE log forwarding at the application level. | `bool` | `false` | no |
| <a name="input_primary_s3_log_bucket_name"></a> [primary\_s3\_log\_bucket\_name](#input\_primary\_s3\_log\_bucket\_name) | Name of bucket to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`. | `string` | `""` | no |
| <a name="input_primary_ssh_keypair_name"></a> [primary\_ssh\_keypair\_name](#input\_primary\_ssh\_keypair\_name) | Name of the SSH public key to associate with the TFE instances. | `string` | `null` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the HashiCorp product that will be installed (tfe, tfefdo, vault, consul) | `string` | `"tfe"` | no |
| <a name="input_secondary_cloudwatch_log_group_name"></a> [secondary\_cloudwatch\_log\_group\_name](#input\_secondary\_cloudwatch\_log\_group\_name) | Name of CloudWatch Log Group to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`. | `string` | `""` | no |
| <a name="input_secondary_common_tags"></a> [secondary\_common\_tags](#input\_secondary\_common\_tags) | Map of common tags for all taggable AWS resources. | `map(string)` | `{}` | no |
| <a name="input_secondary_log_forwarding_enabled"></a> [secondary\_log\_forwarding\_enabled](#input\_secondary\_log\_forwarding\_enabled) | Boolean to enable TFE log forwarding at the application level. | `bool` | `false` | no |
| <a name="input_secondary_s3_log_bucket_name"></a> [secondary\_s3\_log\_bucket\_name](#input\_secondary\_s3\_log\_bucket\_name) | Name of bucket to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`. | `string` | `""` | no |
| <a name="input_secondary_ssh_keypair_name"></a> [secondary\_ssh\_keypair\_name](#input\_secondary\_ssh\_keypair\_name) | Name of the SSH public key to associate with the TFE instances. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_asg_healthcheck_type"></a> [primary\_asg\_healthcheck\_type](#output\_primary\_asg\_healthcheck\_type) | Type of health check that is associated with the AWS autoscaling group. |
| <a name="output_primary_asg_name"></a> [primary\_asg\_name](#output\_primary\_asg\_name) | Name of the AWS autoscaling group that was created during the run. |
| <a name="output_primary_asg_target_group_arns"></a> [primary\_asg\_target\_group\_arns](#output\_primary\_asg\_target\_group\_arns) | List of the target group ARNs that are used for the AWS autoscaling group |
| <a name="output_primary_launch_template_name"></a> [primary\_launch\_template\_name](#output\_primary\_launch\_template\_name) | Name of the AWS launch template that was created during the run |
| <a name="output_primary_security_group_ids"></a> [primary\_security\_group\_ids](#output\_primary\_security\_group\_ids) | List of security groups that have been created during the run. |
| <a name="output_primary_tfe_admin_console_url"></a> [primary\_tfe\_admin\_console\_url](#output\_primary\_tfe\_admin\_console\_url) | URL of TFE (Replicated) Admin Console based on `route53_failover_fqdn` input. |
| <a name="output_primary_tfe_url"></a> [primary\_tfe\_url](#output\_primary\_tfe\_url) | URL of TFE application based on `route53_failover_fqdn` input. |
| <a name="output_primary_user_data_script"></a> [primary\_user\_data\_script](#output\_primary\_user\_data\_script) | base64 decoded user data script that is attached to the launch template |
| <a name="output_secondary_asg_healthcheck_type"></a> [secondary\_asg\_healthcheck\_type](#output\_secondary\_asg\_healthcheck\_type) | Type of health check that is associated with the AWS autoscaling group. |
| <a name="output_secondary_asg_name"></a> [secondary\_asg\_name](#output\_secondary\_asg\_name) | Name of the AWS autoscaling group that was created during the run. |
| <a name="output_secondary_asg_target_group_arns"></a> [secondary\_asg\_target\_group\_arns](#output\_secondary\_asg\_target\_group\_arns) | List of the target group ARNs that are used for the AWS autoscaling group |
| <a name="output_secondary_launch_template_name"></a> [secondary\_launch\_template\_name](#output\_secondary\_launch\_template\_name) | Name of the AWS launch template that was created during the run |
| <a name="output_secondary_security_group_ids"></a> [secondary\_security\_group\_ids](#output\_secondary\_security\_group\_ids) | List of security groups that have been created during the run. |
| <a name="output_secondary_tfe_admin_console_url"></a> [secondary\_tfe\_admin\_console\_url](#output\_secondary\_tfe\_admin\_console\_url) | URL of TFE (Replicated) Admin Console based on `route53_failover_fqdn` input. |
| <a name="output_secondary_tfe_url"></a> [secondary\_tfe\_url](#output\_secondary\_tfe\_url) | URL of TFE application based on `route53_failover_fqdn` input. |
| <a name="output_secondary_user_data_script"></a> [secondary\_user\_data\_script](#output\_secondary\_user\_data\_script) | base64 decoded user data script that is attached to the launch template |
<!-- END_TF_DOCS -->
