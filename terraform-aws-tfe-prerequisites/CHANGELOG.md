
# v1.0.2
## What's Changed
* Updated HVD Examples
* Changed the default for `region` in all examples to ensure users are prompted if it isn't set
* Switched the HVD examples to NLB
* Added input validation for the `redis_password` and `db_password`
* Updated Readmes for examples and main repository
* Bumped Deps
* Bumped TFE module version in examples.
* Nlb hvd by @ml4 in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/57
* chore(deps): update terraform to 1.6.3 by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/58

## New Contributors
* @ml4 made their first contribution in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/57

**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/compare/v1.0.1...v1.0.2

---

# v1.0.1
## What's Changed
* Abc link fix by @abuxton in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/54
* fix(examples): Fixed the module version ref in examples by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/56

## New Contributors
* @abuxton made their first contribution in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/54

**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/compare/v1.0.0...v1.0.1

---
# v1.0.0
## ⚠️ Breaking Changes

## Outputs
- `license_secret_arn` has been removed
- `tfe_console_password_arn` has been removed
- `tfe_enc_password_arn` has been removed
- `replicated_license_secret_arn` has been added
- `tfe_secrets_arn` has been added

## Variables
### Secrets Manager
- `secretsmanager_secrets` has changed to support product submaps 
- Logic was modified to support the new sub-map feature we have been working on. 
---

# Changes

## Examples

- All `terraform.auto.tfvars` have been renamed to `terraform.auto.tfvars.example` to encourage people to read through the file as the 
- Variables have been added across all examples to make them easy to manage and easy for end users to consume. Shifted inputs to `terraform.auto.tfvars` for execution.
- `log_forwarding_type` has been added to all the examples
- variables have been added to reduce back and forth between the module call and the `auto.tfvars`

**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/compare/v0.2.0...v1.0.0

## What's Changed
* docs: update readmes for TF module pin version by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/53
* ci(github-action): update deps-tools group by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/49

---

# v0.2.0

# ⚠️ Breaking Changes

## Outputs
🚚 The following outputs have been renamed:
- `private_subnets` is now `private_subnet_ids`
- `public_subnets` is now `public_subnet_ids`
- `database_subnets` is now `db_subnet_ids`
- `database_subnet_arns` is now `db_subnet_arns`
- `database_subnets_cidr_blocks` is now `db_subnets_cidr_blocks`
- `database_subnets_ipv6_cidr_blocks` is now `db_subnets_ipv6_cidr_blocks`
- `database_subnet_group` is now `db_subnet_group` 
- `license_arn` is now `license_secret_arn` 
- `tfe_log_group_name` is now `cloudwatch_log_group_name` 
- `tfe_keypair_name` is now `ssh_keypair_name`
- `tfe_keypair_arn` is now `ssh_keypair_arn`
- `tfe_keypair_id` is now `ssh_keypair_id`
- `tfe_keypair_fingerprint` is now `ssh_keypair_fingerprint`
- `tfe_iam_role_arn` is now `iam_role_arn`
- `tfe_iam_role_name` is now `iam_role_name`
- `tfe_iam_managed_policy_arn` is now `iam_managed_policy_arn`
- `tfe_iam_managed_policy_name` is now `iam_managed_policy_name`
- `tfe_iam_instance_profile` is now `iam_instance_profile`
- `tfe_asg_hook_value` is now `asg_hook_value`

## Variables
### Route53
- `r53_domain_name` is now `route53_zone_name`
- `r53_private_zone` is now `route53_private_zone`
- `r53_failover_record` is now `route53_failover_record`
- `r53_record_health_check_enabled` is now `route53_record_health_check_enabled`

### Ingress
- `lb_subnets` is now `lb_subnet_ids`. This now accurately reflects that the input should be referencing the ID of the subnet opposed to CIDR blocks. 

### KMS

- `kms_asg_role_arn` is now `kms_asg_role_arns` and is a `list(string)` to accommodate for multiple KMS keys 

### SSH

- `tfe_ssh_public_key` is now `ssh_public_key`
- `create_tfe_keypair` is now `create_ssh_keypair`

### Versions

- Minimum required Terraform version is now `1.5.0` 

---

# Changes

## Examples

- All `terraform.auto.tfvars` have been renamed to `terraform.auto.tfvars.example` to encourage people to read through the file as the `plan` / `apply` operation will prompt for inputs
- All examples now use the `v0.2.0` of the `terraform-aws-tfe` module
- All `README.MD` files have been updated in the examples
- All TFE examples that use Replicated now use the input `tls_bootstrap_type` in the deployment module. This utilizes a generated certificate for the TFE instance instead of using the Replicated self-signed cert. In the future when deploying FDO a certificate is **REQUIRED** as Replicated isn't present to generate them. This was done to encourage users to generate certificates as a part of the deployment. You can change the value of the input back to `self-signed` if you want to use a self-signed certificate as a part of a demo or deployment with a Replicated instance (not recommended).
- Defaults for variables in the examples have been removed 
- 🗑️ `public-tfe-active-standby-aurora-alb` has been removed
- 🗑️ `public-tfe-active-standby-aurora-nlb` has been removed
- 🗑️ `public-tfe-active-active-nlb` has been removed
- 🗑️ `public-tfe-active-active-alb` has been removed
- ➕ `public-tfe-fdo-active-standby-aurora-alb` has been added
- ➕ `public-tfe-fdo-active-standby-aurora-nlb` has been added
- ➕ `public-tfe-fdo-active-nlb` has been added
- ➕ `public-tfe-fdo-active-alb` has been added
- ➕ `hvd-tfe` has been added

- Variables have been added across all examples to make them easy to manage and easy for end users to consume. Shifted inputs to `terraform.auto.tfvars` for execution.

## Variables

### Networking

- `vpc_default_security_group_egress` has been added. This allows for a list of maps of egress rules to be set on the default security group that would be created when setting `create_vpc = true` 
- `vpc_default_security_group_ingress` has been added. This allows for a list of maps of ingress rules to be set on the default security group that would be created when setting `create_vpc = true` 
- `vpc_endpoint_flags` has been added. This allows for the VPC endpoints to be created conditionally based on the user's use case
- `vpc_option_flags` has been added. This allows for specific optional flags to be set on the VPC when `create_vpc = true` 

## Taskfile
- Taskfile has been updated to allow for branches to be specified when generating a bundle. Additional support for cloud names to be specified via a variable in the task.
- Output artifact that is generated is now using the naming convention `{{.DEPLOY_DIR}}-bundle.zip`. This means the artifact will be named `terraform-aws-tfe-bundle.zip` 
- Sub folders within the zip are now clearer. The should be named `terraform-aws-tfe` and `terraform-aws-tfe-prerequisites` 

## What's Changed
* 46 refactor by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/48
* ci(github-action): update deps-tools group by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/40
* feat(github-release)!: Update actions/checkout action to v4 by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/pull/44


**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe-prerequisites/compare/v0.1.2...v0.2.0