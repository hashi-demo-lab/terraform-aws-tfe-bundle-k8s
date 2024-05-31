# TFE on AWS Deployment Module

This Terraform module is intended to deploy TFE on AWS. Every environment is different, and so this module may not be all-encompassing for every situation.

**If you are doing greenfield deployments of TFE, please use FDO (Flexible Deployment Option) as replicated Will be deprecated in the future.**

---

## Purpose
These modules are currently for [hyper-specialized tier partners](https://www.hashicorp.com/partners/find-a-partner?category=systems-integrators), internal use, and HashiCorp Professional Services. Please reach out in #team-ent-deployment-modules if you want to use this with your customers.

## Usage
Take a look at the examples folder. Select and exmaple that works for your deployment

1. Rename the `terraform.auto.tfvars.example` to `terraform.auto.tfvars`
2. Modify the `terraform.auto.tfvars` file to be specific to your environment
3. `terraform init`
4. `terraform plan`
5. `terraform apply`

An overview of the module architecture is provided in [LucidChart](https://lucid.app/lucidchart/9bf9c5f3-cfbf-4262-9990-f965fb7a138d/edit?invitationId=inv_56f1eba4-910f-418a-97e6-5ff4036db164&page=0_0) .

## Support
Please be aware that HashiCorp does not provide official support for the deployment modules. Product-level support falls within the scope of your support package, the module code itself does not include any support or guarantee.

---

# 📝 Note
If you don't have the prerequisites created, please see the other repository for the examples that focus on the deployment of the prerequisites required for the product.

| Example | Description |
| ------- | ----------- |
| [private-tfe-active-active-alb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/private-tfe-active-active-alb)  | Builds all prerequisite infrastructure with an ALB in an airgap configuration |
| [private-tfe-active-active-nlb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/private-tfe-active-active-nlb)  | Builds all prerequisite infrastructure with an NLB in an airgap configuration |
| [private-tfe-single-site-airgap-alb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/private-tfe-single-site-airgap-alb) | Builds all prerequisite infrastructure with an ALB and a single node in an airgap configuration |
| [public-tfe-fdo-active-active-alb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/public-tfe-fdo-active-active-alb) | Builds all prerequisite infrastructure with an ALB for a publicly accessible FDO implementation |
| [public-tfe-fdo-active-active-nlb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/public-tfe-fdo-active-active-nlb) | Builds all prerequisite infrastructure with an NLB for a publicly accessible FDO implementation |
| [public-tfe-fdo-active-standby-aurora-nlb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/public-tfe-fdo-active-standby-aurora-nlb) | Multi-site TFE FDO deployment - Module builds all prerequisites at both sites as well as deploys FDO with a fronting NLB |
| [public-tfe-fdo-active-standby-aurora-alb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/public-tfe-fdo-active-standby-aurora-alb) |Multi-site TFE FDO deployment - Module builds all prerequisites at both sites as well as deploys FDO with a fronting ALB |
| [public-tfe-fdo-single-site-aurora-alb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/public-tfe-fdo-single-site-aurora-alb) | Builds all prerequisite infrastructure with an ALB fronting a single TFE FDO node |
| [public-tfe-single-site-aurora-nlb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/public-tfe-single-site-aurora-nlb)| Builds all prerequisite infrastructure with an NLB and a single TFE (Replicated) node |
| [hvd-tfe](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/hvd-tfe) | HashiCorp Validated Designs TFE FDO deployment. Module builds all prerequisite infrastructure with an ALB. |
| [public-tfe-single-site-postgres-rds-multi-az-alb](https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/tree/main/examples/public-tfe-single-site-postgres-rds-multi-az-alb)  | Builds all prerequisite infrastructure with an ALB and a single TFE (Replicated) Node that uses traditional RDS. |

--- 
 
## 📂 Example scenarios and structure

The Git repository contains the following directories under `examples` and should be used as references when consuming the module

```sh
📁 examples                                             # Root example folder
├─📁 hvd-tfe                                            # Deployment for the HashiCorp Validated Designs. Active/Active FDO deployment with an ALB and Aurora DB
├─📁 private-tfe-active-active-alb                      # Deployment of a private TFE architecture in Active/Active with an NLB
├─📁 private-tfe-active-active-nlb                      # Deployment of a private TFE deployment in Active/Active with an NLB
├─📁 private-tfe-single-site-airgap-alb                 # Deployment of a private TFE deployment in an airgap configuration with an ALB
├─📁 public-tfe-fdo-active-active-alb                   # Deployment of a public TFE FDO deployment in Active/Active with an ALB
├─📁 public-tfe-fdo-active-active-nlb                   # Deployment of a public TFE FDO deployment in Active/Active with an NLB
├─📁 public-tfe-fdo-active-standby-aurora-alb           # Deployment of a Multi-site arcitecture in an Active/Standby configuration with an Aurora Global DB and an ALB
├─📁 public-tfe-fdo-active-standby-aurora-nlb           # Deployment of a Multi-site architecture in an Active/Standby configuration with an Aurora Global DB and an NLB
├─📁 public-tfe-fdo-single-site-aurora-alb              # Deployment of a single-site/node architecture using an ALB and Aurora DB
├─📁 public-tfe-single-site-aurora-nlb                  # Deployment of a single-site/node deployment using an NLB and Aurora DB
├─📁 public-tfe-single-site-postgres-rds-multi-az-alb   # Deployment of a single-site/node deployment using an ALB and an RDS Postgres DB
```

### Example Scenarios. 
- [hvd-tfe](./examples/hvd-tfe/README.md) 
- [private-tfe-active-active-alb](./examples/private-tfe-active-active-alb/README.md)
- [private-tfe-active-active-nlb](./examples/private-tfe-active-active-nlb/README.md)
- [private-tfe-single-site-airgap-alb](./examples/private-tfe-single-site-airgap-alb/README.md)
- [public-tfe-fdo-active-active-alb](./examples/public-tfe-fdo-active-active-alb/README.md) 
- [public-tfe-fdo-active-active-alb](./examples/public-tfe-fdo-active-active-alb/README.md)
- [public-tfe-fdo-active-standby-aurora-alb](./examples/public-tfe-fdo-active-standby-aurora-alb/README.md)
- [public-tfe-fdo-active-standby-aurora-nlb](./examples/public-tfe-fdo-active-standby-aurora-nlb/README.md)
- [public-tfe-fdo-single-site-aurora-alb](./examples/public-tfe-single-site-aurora-alb/README.md)
- [public-tfe-single-site-aurora-nlb](./examples/public-tfe-single-site-aurora-nlb/README.md)
- [public-tfe-single-site-aurora-alb](./examples/public-tfe-single-site-aurora-alb/README.md)
- [public-tfe-single-site-postgres-rds-multi-az-alb](./examples/public-tfe-single-site-postgres-rds-multi-az-alb/README.md)

---

## Submodules in use:

- [terraform-null-cloudinit-function-template](https://github.com/hashicorp-modules/terraform-null-cloudinit-function-template)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_init_generic_functions"></a> [cloud\_init\_generic\_functions](#module\_cloud\_init\_generic\_functions) | github.com/hashicorp-modules/terraform-null-cloudinit-function-template | v0.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.ec2_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ec2_allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_console](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_console_from_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_https_from_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_metrics_http_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_metrics_http_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_metrics_https_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_metrics_https_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_ingress_allow_vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.redis_ingress_allow_redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ami.centos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.rhel](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ecr_repository.custom_tbw_image](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_hook_value"></a> [asg\_hook\_value](#input\_asg\_hook\_value) | Value for the tag that is associated with the launch template. This is used for the lifecycle hook checkin. | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for the DB user. | `string` | n/a | yes |
| <a name="input_ec2_subnet_ids"></a> [ec2\_subnet\_ids](#input\_ec2\_subnet\_ids) | List of subnet IDs to use for the EC2 instance. Private subnets is the best practice. | `list(string)` | n/a | yes |
| <a name="input_friendly_name_prefix"></a> [friendly\_name\_prefix](#input\_friendly\_name\_prefix) | String value for friendly name prefix for AWS resource names. | `string` | n/a | yes |
| <a name="input_permit_all_egress"></a> [permit\_all\_egress](#input\_permit\_all\_egress) | Whether broad (0.0.0.0/0) egress should be permitted on cluster nodes. If disabled, additional rules must be added to permit HTTP(S) and other necessary network access. | `bool` | n/a | yes |
| <a name="input_tfe_hostname"></a> [tfe\_hostname](#input\_tfe\_hostname) | Hostname/FQDN of TFE instance. This name should resolve to the load balancer DNS name and will be how users and systems access TFE. | `string` | n/a | yes |
| <a name="input_tfe_secrets_arn"></a> [tfe\_secrets\_arn](#input\_tfe\_secrets\_arn) | ARN of the secret in AWS Secrets Manager that contains all of the TFE secrets | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID that TFE will be deployed into. | `string` | n/a | yes |
| <a name="input_airgap_install"></a> [airgap\_install](#input\_airgap\_install) | Boolean for TFE installation method to be airgap. | `bool` | `false` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | Custom AMI ID for TFE EC2 Launch Template. If specified, value of `os_distro` must coincide with this custom AMI OS distro. | `string` | `null` | no |
| <a name="input_asg_capacity_timeout"></a> [asg\_capacity\_timeout](#input\_asg\_capacity\_timeout) | Maximum duration that Terraform should wait for ASG instances to be healthy before timing out | `string` | `"17m"` | no |
| <a name="input_asg_custom_role_arn"></a> [asg\_custom\_role\_arn](#input\_asg\_custom\_role\_arn) | Custom role ARN that will be assigned to the autoscaling group (if specified). Defaults to the AWS native role. | `string` | `null` | no |
| <a name="input_asg_health_check_grace_period"></a> [asg\_health\_check\_grace\_period](#input\_asg\_health\_check\_grace\_period) | The amount of time to wait for a new TFE instance to be healthy. If this threshold is breached, the ASG will terminate the instance and launch a new one. | `number` | `900` | no |
| <a name="input_asg_health_check_type"></a> [asg\_health\_check\_type](#input\_asg\_health\_check\_type) | Health check type for the ASG to use when determining if an endpoint is healthy | `string` | `"ELB"` | no |
| <a name="input_asg_instance_count"></a> [asg\_instance\_count](#input\_asg\_instance\_count) | Desired number of EC2 instances to run in Autoscaling Group. Leave at `1` unless Active/Active is enabled. | `number` | `1` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Max number of EC2 instances to run in Autoscaling Group. Increase after Active/Active is enabled. | `number` | `1` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Min number of EC2 instances to run in Autoscaling Group. Increase after Active/Active is enabled. | `number` | `1` | no |
| <a name="input_ca_bundle_secret_arn"></a> [ca\_bundle\_secret\_arn](#input\_ca\_bundle\_secret\_arn) | ARN of AWS Secrets Manager secret for private/custom CA bundles. New lines must be replaced by `<br>` character prior to storing as a plaintext secret. | `string` | `""` | no |
| <a name="input_capacity_concurrency"></a> [capacity\_concurrency](#input\_capacity\_concurrency) | Total concurrent Terraform Runs (Plans/Applies) allowed within TFE. | `string` | `"10"` | no |
| <a name="input_capacity_memory"></a> [capacity\_memory](#input\_capacity\_memory) | Maxium amount of memory (MB) that a Terraform Run (Plan/Apply) can consume within TFE. | `string` | `"512"` | no |
| <a name="input_cloud"></a> [cloud](#input\_cloud) | Name of the cloud we are provisioning on. This is used for templating functions and is default to AWS for this module. | `string` | `"aws"` | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | Name of CloudWatch Log Group to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`. | `string` | `""` | no |
| <a name="input_cloudwatch_retention_in_days"></a> [cloudwatch\_retention\_in\_days](#input\_cloudwatch\_retention\_in\_days) | Days to retain CloudWatch logs | `number` | `14` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Map of common tags for taggable AWS resources. | `map(string)` | `{}` | no |
| <a name="input_consolidated_services"></a> [consolidated\_services](#input\_consolidated\_services) | Boolean that when true, will deploy TFE (Replicated) in a consolidated services architecture. | `bool` | `true` | no |
| <a name="input_custom_fluent_bit_config"></a> [custom\_fluent\_bit\_config](#input\_custom\_fluent\_bit\_config) | A custom FluentBit config for TFE logging. | `string` | `null` | no |
| <a name="input_custom_tbw_ecr_repo"></a> [custom\_tbw\_ecr\_repo](#input\_custom\_tbw\_ecr\_repo) | Name of AWS Elastic Container Registry (ECR) Repository where custom Terraform Build Worker (tbw) image exists. Only specify if `tbw_image` is set to `custom_image`. | `string` | `""` | no |
| <a name="input_custom_tbw_image_tag"></a> [custom\_tbw\_image\_tag](#input\_custom\_tbw\_image\_tag) | Tag of custom Terraform Build Worker (tbw) image. Examples: `v1`, `latest`. Only specify if `tbw_image` is set to `custom_image`. | `string` | `"latest"` | no |
| <a name="input_db_cluster_endpoint"></a> [db\_cluster\_endpoint](#input\_db\_cluster\_endpoint) | Writer endpoint for the cluster | `string` | `""` | no |
| <a name="input_db_database_name"></a> [db\_database\_name](#input\_db\_database\_name) | Name of database that will be created (if specified) or consumed by TFE. | `string` | `"tfe"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Port that the Postgres instance is listening on. | `string` | `"5432"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for the DB user. | `string` | `"tfe"` | no |
| <a name="input_docker_version"></a> [docker\_version](#input\_docker\_version) | Version of docker to install as a part of the pre-reqs | `string` | `"24.0.4"` | no |
| <a name="input_ebs_iops"></a> [ebs\_iops](#input\_ebs\_iops) | The amount of IOPS to provision for a `gp3` volume. Must be at least `3000`. | `number` | `3000` | no |
| <a name="input_ebs_is_encrypted"></a> [ebs\_is\_encrypted](#input\_ebs\_is\_encrypted) | Boolean for encrypting the root block device of the TFE EC2 instance(s). | `bool` | `true` | no |
| <a name="input_ebs_throughput"></a> [ebs\_throughput](#input\_ebs\_throughput) | The throughput to provision for a `gp3` volume in MB/s. Must be at least `125` MB/s. | `number` | `125` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | The size of the boot volume for TFE type. Must be at least `50` GB. | `number` | `50` | no |
| <a name="input_ebs_volume_type"></a> [ebs\_volume\_type](#input\_ebs\_volume\_type) | The volume type. Choose from `gp3`. | `string` | `"gp3"` | no |
| <a name="input_enable_active_active"></a> [enable\_active\_active](#input\_enable\_active\_active) | Boolean to enable TFE Active/Active and in turn deploy Redis cluster. | `bool` | `false` | no |
| <a name="input_enable_metrics_collection"></a> [enable\_metrics\_collection](#input\_enable\_metrics\_collection) | Boolean to enable internal TFE metrics collection. | `bool` | `true` | no |
| <a name="input_extra_no_proxy"></a> [extra\_no\_proxy](#input\_extra\_no\_proxy) | A comma-separated string of hostnames or IP addresses to add to the TFE no\_proxy list. Only specify if a value for `http_proxy` is also specified. | `string` | `""` | no |
| <a name="input_force_tls"></a> [force\_tls](#input\_force\_tls) | Boolean to require all internal TFE application traffic to use HTTPS by sending a 'Strict-Transport-Security' header value in responses, and marking cookies as secure. Only enable if `tls_bootstrap_type` is `server-path`. | `bool` | `false` | no |
| <a name="input_hairpin_addressing"></a> [hairpin\_addressing](#input\_hairpin\_addressing) | Boolean to enable TFE services to direct requests to the servers' internal IP address rather than the TFE hostname/FQDN. Only enable if `tls_bootstrap_type` is `server-path`. | `bool` | `false` | no |
| <a name="input_http_proxy"></a> [http\_proxy](#input\_http\_proxy) | Proxy address to configure for TFE to use for outbound connections/requests. | `string` | `""` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | Name of AWS IAM Instance Profile for TFE EC2 Instance | `string` | `""` | no |
| <a name="input_ingress_cidr_22_allow"></a> [ingress\_cidr\_22\_allow](#input\_ingress\_cidr\_22\_allow) | List of CIDR ranges to allow SSH ingress to TFE EC2 instance (i.e. bastion host IP, workstation IP, etc.). | `list(string)` | `[]` | no |
| <a name="input_ingress_cidr_443_allow"></a> [ingress\_cidr\_443\_allow](#input\_ingress\_cidr\_443\_allow) | List of CIDR ranges to allow ingress traffic on port 443 to TFE server or load balancer. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_ingress_cidr_8800_allow"></a> [ingress\_cidr\_8800\_allow](#input\_ingress\_cidr\_8800\_allow) | List of CIDR ranges to allow TFE Replicated admin console (port 8800) traffic ingress to TFE server or load balancer. | `list(string)` | `null` | no |
| <a name="input_install_docker_before"></a> [install\_docker\_before](#input\_install\_docker\_before) | Boolean to install docker before TFE install script is called. | `bool` | `false` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | EC2 instance type for TFE Launch Template. | `string` | `"m5.xlarge"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of KMS key to encrypt TFE RDS, S3, EBS, and Redis resources. | `string` | `""` | no |
| <a name="input_launch_template_sg_ids"></a> [launch\_template\_sg\_ids](#input\_launch\_template\_sg\_ids) | List of additional Security Group IDs to associate with the AWS Launch Template | `list(string)` | `[]` | no |
| <a name="input_lb_security_group_id"></a> [lb\_security\_group\_id](#input\_lb\_security\_group\_id) | Security Group ID for the Load Balancer | `string` | `""` | no |
| <a name="input_lb_tg_arns"></a> [lb\_tg\_arns](#input\_lb\_tg\_arns) | List of Target Group ARNs associated with the TFE Load Balancer | `list(any)` | `[]` | no |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | String indicating whether the load balancer deployed is an Application Load Balancer (alb) or Network Load Balancer (nlb). | `string` | `"application"` | no |
| <a name="input_lifecycle_hook_timeout"></a> [lifecycle\_hook\_timeout](#input\_lifecycle\_hook\_timeout) | Duration in seconds that the lifecycle hook will wait for a timeout. | `number` | `600` | no |
| <a name="input_log_forwarding_enabled"></a> [log\_forwarding\_enabled](#input\_log\_forwarding\_enabled) | Boolean to enable TFE log forwarding at the application level. | `bool` | `false` | no |
| <a name="input_log_forwarding_type"></a> [log\_forwarding\_type](#input\_log\_forwarding\_type) | Which type of log forwarding to configure. For any of these,`var.log_forwarding_enabled` must be set to `true`. For  S3, specify `s3` and supply a value for `var.s3_log_bucket_name`, for Cloudwatch specify `cloudwatch` and `var.cloudwatch_log_group_name`, for custom, specify `custom` and supply a valid fluentbit config in `var.custom_fluent_bit_config`. | `string` | `"s3"` | no |
| <a name="input_log_path"></a> [log\_path](#input\_log\_path) | Log path glob pattern to capture log files with logging agent | `string` | `"/var/log/*"` | no |
| <a name="input_metrics_endpoint_allow_cidr"></a> [metrics\_endpoint\_allow\_cidr](#input\_metrics\_endpoint\_allow\_cidr) | The CIDR to allow access to the TFE metrics endpoint. | `list(string)` | `null` | no |
| <a name="input_metrics_endpoint_allow_sg"></a> [metrics\_endpoint\_allow\_sg](#input\_metrics\_endpoint\_allow\_sg) | The Security Groups to allow access to the TFE metrics endpoint. | `string` | `null` | no |
| <a name="input_metrics_endpoint_enabled"></a> [metrics\_endpoint\_enabled](#input\_metrics\_endpoint\_enabled) | Boolean to enable the TFE metrics endpoint. | `bool` | `false` | no |
| <a name="input_metrics_endpoint_port_http"></a> [metrics\_endpoint\_port\_http](#input\_metrics\_endpoint\_port\_http) | Defines the TCP port on which HTTP metrics requests will be handled. | `number` | `9090` | no |
| <a name="input_metrics_endpoint_port_https"></a> [metrics\_endpoint\_port\_https](#input\_metrics\_endpoint\_port\_https) | Defines the TCP port on which HTTPS metrics requests will be handled. | `number` | `9091` | no |
| <a name="input_os_distro"></a> [os\_distro](#input\_os\_distro) | Linux OS distribution for TFE EC2 instance. Choose from `ubuntu`, `rhel`, `centos`. | `string` | `"ubuntu"` | no |
| <a name="input_pkg_repos_reachable_with_airgap"></a> [pkg\_repos\_reachable\_with\_airgap](#input\_pkg\_repos\_reachable\_with\_airgap) | Boolean to install prereq software dependencies if airgapped. Only valid when `airgap_install` is `true`. | `bool` | `false` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the HashiCorp product that will be installed (tfe, tfefdo, vault, consul) | `string` | `"tfe"` | no |
| <a name="input_redis_host"></a> [redis\_host](#input\_redis\_host) | Redis of the primary node for the Redis configuration | `string` | `""` | no |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | Password (auth token) used to enable transit encryption (TLS) with Redis. | `string` | `""` | no |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | Port number the Redis nodes will accept connections on. | `number` | `6379` | no |
| <a name="input_redis_security_group_id"></a> [redis\_security\_group\_id](#input\_redis\_security\_group\_id) | Existing security group ID that is attatched to the redis cluster. This will be used when adding rules to access the cluster from the TFE instances. | `string` | `""` | no |
| <a name="input_remove_import_settings_from"></a> [remove\_import\_settings\_from](#input\_remove\_import\_settings\_from) | Replicated setting to automatically remove the `/etc/tfe-settings.json` file (referred to as `ImportSettingsFrom` by Replicated) after installation. | `bool` | `false` | no |
| <a name="input_replicated_bundle_path"></a> [replicated\_bundle\_path](#input\_replicated\_bundle\_path) | Path to Replicated tarball (`replicated.tar.gz`) stored in `tfe_bootstrap_bucket`. Path should start with `s3://`. Only specify if `airgap_install` is `true`. | `string` | `""` | no |
| <a name="input_replicated_license_secret_arn"></a> [replicated\_license\_secret\_arn](#input\_replicated\_license\_secret\_arn) | ARN of the secret in AWS Secrets Manager that contains all of the TFE Replicated license | `string` | `""` | no |
| <a name="input_restrict_worker_metadata_access"></a> [restrict\_worker\_metadata\_access](#input\_restrict\_worker\_metadata\_access) | Boolean to block Terraform build worker containers from being able to access the EC2 instance metadata endpoint. | `bool` | `false` | no |
| <a name="input_s3_app_bucket_name"></a> [s3\_app\_bucket\_name](#input\_s3\_app\_bucket\_name) | Name of S3 S3 Terraform Enterprise Object Store bucket. | `string` | `""` | no |
| <a name="input_s3_log_bucket_name"></a> [s3\_log\_bucket\_name](#input\_s3\_log\_bucket\_name) | Name of bucket to configure as log forwarding destination. `log_forwarding_enabled` must also be `true`. | `string` | `""` | no |
| <a name="input_ssh_key_pair"></a> [ssh\_key\_pair](#input\_ssh\_key\_pair) | Name of existing SSH key pair to attach to TFE EC2 instance. | `string` | `""` | no |
| <a name="input_tbw_image"></a> [tbw\_image](#input\_tbw\_image) | Terraform Build Worker container image to use. Set this to `custom_image` to use alternative container image. | `string` | `"default_image"` | no |
| <a name="input_tfe_airgap_bundle_path"></a> [tfe\_airgap\_bundle\_path](#input\_tfe\_airgap\_bundle\_path) | Path to TFE airgap bundle stored in `tfe_bootstrap_bucket`. Path should start with `s3://`. Only specify if `airgap_install` is `true`. | `string` | `""` | no |
| <a name="input_tfe_cert_secret_arn"></a> [tfe\_cert\_secret\_arn](#input\_tfe\_cert\_secret\_arn) | ARN of AWS Secrets Manager secret for TFE server certificate in PEM format. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored. | `string` | `""` | no |
| <a name="input_tfe_config_directory"></a> [tfe\_config\_directory](#input\_tfe\_config\_directory) | Directory on the EC2 instance where the configuration for TFE will be stored. | `string` | `"/etc/tfe"` | no |
| <a name="input_tfe_fdo_release_sequence"></a> [tfe\_fdo\_release\_sequence](#input\_tfe\_fdo\_release\_sequence) | TFE release sequence to use during deployment. This specifies which TFE version to install. | `any` | `"v202309-1"` | no |
| <a name="input_tfe_iact_settings"></a> [tfe\_iact\_settings](#input\_tfe\_iact\_settings) | "Object map for the TFE IACT Settings used with TFE FDO<br>  `iact_subnets` is a list of IPs in CIDR format eg. "10.0.0.0/24,10.1.1.1/24" that can request an initial admin token<br>  `iact_trusted_proxies` is a list of proxy IPs that allow for retrieval of the initial admin token<br>  `iact_time_limit` is the duration in which the retreival is allowed" | <pre>object({<br>    iact_subnets         = optional(string, "")<br>    iact_trusted_proxies = optional(string, "")<br>    iact_time_limit      = optional(string, "60")<br>  })</pre> | `{}` | no |
| <a name="input_tfe_privkey_secret_arn"></a> [tfe\_privkey\_secret\_arn](#input\_tfe\_privkey\_secret\_arn) | ARN of AWS Secrets Manager secret for TFE private key in PEM format and base64 encoded. Required if `tls_bootstrap_type` is `server-path`; otherwise ignored. | `string` | `""` | no |
| <a name="input_tfe_release_sequence"></a> [tfe\_release\_sequence](#input\_tfe\_release\_sequence) | TFE release sequence number within Replicated. This specifies which TFE version to install for an `online` install. Ignored if `airgap_install` is `true`. | `any` | `"733"` | no |
| <a name="input_tls_bootstrap_type"></a> [tls\_bootstrap\_type](#input\_tls\_bootstrap\_type) | Defines where to terminate TLS/SSL. Set to `self-signed` to terminate at the load balancer, or `server-path` to terminate at the instance-level. | `string` | `"self-signed"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_healthcheck_type"></a> [asg\_healthcheck\_type](#output\_asg\_healthcheck\_type) | Type of health check that is associated with the AWS autoscaling group. |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | Name of the AWS autoscaling group that was created during the run. |
| <a name="output_asg_target_group_arns"></a> [asg\_target\_group\_arns](#output\_asg\_target\_group\_arns) | List of the target group ARNs that are used for the AWS autoscaling group |
| <a name="output_launch_template_name"></a> [launch\_template\_name](#output\_launch\_template\_name) | Name of the AWS launch template that was created during the run |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | List of security groups that have been created during the run. |
| <a name="output_tfe_admin_console_url"></a> [tfe\_admin\_console\_url](#output\_tfe\_admin\_console\_url) | URL of TFE (Replicated) Admin Console based on `tfe_hostname` input. |
| <a name="output_tfe_url"></a> [tfe\_url](#output\_tfe\_url) | URL of TFE application based on `tfe_hostname` input. |
| <a name="output_user_data_script"></a> [user\_data\_script](#output\_user\_data\_script) | base64 decoded user data script that is attached to the launch template |
<!-- END_TF_DOCS -->