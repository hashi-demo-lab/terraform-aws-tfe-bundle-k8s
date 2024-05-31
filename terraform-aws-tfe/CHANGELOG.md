# v1.0.2

- `region` default has been removed from examples
- `hvd-tfe` example has been modified for NLB and the correct number of nodes
- bumped deps

## What's Changed
* Fix typos, document README, bump ASG=3, drop region default, nlb pref by @ml4 in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/43
* chore(deps): update terraform to 1.6.3 by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/46
* docs(readme): add support disclaimer by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/48

## New Contributors
* @ml4 made their first contribution in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/43

**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe/compare/v1.0.1...v1.0.2

---

# v1.0.1

## What's Changed
* Abc link fix by @abuxton in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/41
* fix(fdo): fix license retrieval issue with returns by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/42

## New Contributors
* @abuxton made their first contribution in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/41

**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe/compare/v1.0.0...v1.0.1

---

# v1.0.0
## ⚠️  Breaking Changes

- `enc_password_arn` has been removed
- `console_password_arn` has been removed
- `license_secret_arn` has been removed
 - `replicated_license_secret_arn` has been added for all replicated license retrieval using the updated secrets manager module
 - `tfe_secrets_arn` has been added to support json based secrets for the application. This is to align with our standard product submap pattern moving forward.

## Non Breaking
 - fluentbit has had `auto_create_group` added to it's configuration for `cloudwatch`
 - Secrets retrieval has been modified within the template scripts
 - Additional docker volume has been added when `log_forward_enabled` is set to true. This will mount the fluentbit config into the fdo container to forward logs to `s3` or `cloudwatch` 
 - `configure_log_forwarding` function call in the template script is now being called for `fdo` based deployments 
 - encoding method for `user_data` of the instances has been swapped from `base64encode` to `base64gzip`. This resolves issues where we were hitting the limit of 16K on AWS. 
 - All examples have `log_fowarding_enabled` and `log_forwarding_type` for variable inputs
 - All examples have been modified to reflect the new license process

## What's Changed
* fix!: updated secret logic, updated examples by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/39
* docs: update examples to include log_forwarding_type by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/40
* ci(github-action): update deps-tools group by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/38


**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe/compare/v0.2.0...v1.0.0

---

# v0.2.0
## ⚠️  Breaking Changes

- `load_balancer_type` is now `lb_type`
- `tfe_asg_hook_value` is now `asg_hook_value`
- `tfe_license_arn` is now `license_secret_arn`
- `target_group_arns` is now `lb_tg_arns`
- `allow_all_egress` is now a required input which if true will allow all traffic to egress from the instance.
- `tfe_keypair_name` is now `ssh_keypair_name`
-  `asg_lifecycle_hook_name` has been removed as an output since the lifecycle hook is now being created as part of the ASG creation.
- `quay_password_secret_arn` has been removed due to FDO GA
- `quay_user_secret_arn` has been removed due to FDO GA
- 2 Security group model is now collapsed into a single security group
- FDO image retrieval now uses the license to retrieve the container and quay has been removed due to GA

# Non Breaking
- `tfe_release_sequence` now defaults to `733`
- New variable `tfe_fdo_release_sequence` now defaults to `v202309-1`
- Defaults have been removed from the examples and `terraform.auto.tfvars` has been renamed to `terraform.auto.tfvars.example` to encourage users to read the docs.
- Active/Standby examples have been switched to FDO
- Majority of examples have been switch to FDO
- `tfe_iact_settings` has been added as an input 
- `load_balancer_scheme` has been removed as it wasn't being referenced
- `asg_capacity_timeout` has been increased to `17m`
- `launch_template_sg_ids` has been added to associate additional security groups with the launch template.


Closes #36 #35 #31 #18


## What's Changed
* fix!: Consistent outputs and inputs, updated examples by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/36
* feat(github-release)!: Update actions/checkout action to v4 by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/32
* chore(deps): update deps-tools group by @renovate in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/26
* docs: add switchover comment to failover portions of readme by @kalenarndt in https://github.com/hashicorp-modules/terraform-aws-tfe/pull/37


**Full Changelog**: https://github.com/hashicorp-modules/terraform-aws-tfe/compare/v0.1.4...v0.2.0