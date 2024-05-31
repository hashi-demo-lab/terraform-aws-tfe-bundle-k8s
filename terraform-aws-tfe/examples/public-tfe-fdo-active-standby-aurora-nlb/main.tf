module "primary_tfe" {
  providers = {
    aws = aws.primary
  }
  source                    = "../../"
  permit_all_egress         = var.primary_permit_all_egress
  friendly_name_prefix      = var.friendly_name_prefix
  tfe_fdo_release_sequence  = var.tfe_fdo_release_sequence
  ssh_key_pair              = var.primary_ssh_keypair_name
  vpc_id                    = var.primary_vpc_id
  tfe_hostname              = var.primary_tfe_hostname
  enable_active_active      = var.tfe_active_active
  iam_instance_profile      = var.primary_iam_profile_name
  kms_key_arn               = var.primary_kms_key_arn
  ec2_subnet_ids            = var.primary_ec2_subnet_ids
  lb_tg_arns                = var.primary_lb_tg_arns
  lb_type                   = var.lb_type
  s3_app_bucket_name        = var.primary_s3_app_bucket_name
  s3_log_bucket_name        = var.primary_s3_log_bucket_name
  cloudwatch_log_group_name = var.primary_cloudwatch_log_group_name
  log_forwarding_enabled    = var.primary_log_forwarding_enabled
  tfe_secrets_arn           = var.primary_tfe_secrets_arn
  tfe_cert_secret_arn       = var.primary_tfe_cert_secret_arn
  tfe_privkey_secret_arn    = var.primary_tfe_privkey_secret_arn
  ca_bundle_secret_arn      = var.primary_ca_bundle_secret_arn
  db_username               = var.db_username
  db_password               = var.db_password
  db_database_name          = var.db_database_name
  db_cluster_endpoint       = var.primary_db_cluster_endpoint
  asg_hook_value            = var.primary_asg_hook_value
  product                   = var.product
  asg_min_size              = 1
  asg_max_size              = 1
  asg_instance_count        = 1
  common_tags               = var.primary_common_tags
}

module "secondary_tfe" {
  providers = {
    aws = aws.secondary
  }
  source                    = "../../"
  permit_all_egress         = var.secondary_permit_all_egress
  friendly_name_prefix      = var.friendly_name_prefix
  tfe_fdo_release_sequence  = var.tfe_fdo_release_sequence
  ssh_key_pair              = var.secondary_ssh_keypair_name
  vpc_id                    = var.secondary_vpc_id
  tfe_hostname              = var.secondary_tfe_hostname
  enable_active_active      = var.tfe_active_active
  iam_instance_profile      = var.secondary_iam_profile_name
  kms_key_arn               = var.secondary_kms_key_arn
  ec2_subnet_ids            = var.secondary_ec2_subnet_ids
  lb_tg_arns                = var.secondary_lb_tg_arns
  lb_type                   = var.lb_type
  s3_app_bucket_name        = var.secondary_s3_app_bucket_name
  s3_log_bucket_name        = var.secondary_s3_log_bucket_name
  cloudwatch_log_group_name = var.secondary_cloudwatch_log_group_name
  log_forwarding_enabled    = var.secondary_log_forwarding_enabled
  tfe_secrets_arn           = var.secondary_tfe_secrets_arn
  tfe_cert_secret_arn       = var.secondary_tfe_cert_secret_arn
  tfe_privkey_secret_arn    = var.secondary_tfe_privkey_secret_arn
  ca_bundle_secret_arn      = var.secondary_ca_bundle_secret_arn
  db_username               = var.db_username
  db_password               = var.db_password
  db_database_name          = var.db_database_name
  db_cluster_endpoint       = var.secondary_db_cluster_endpoint
  asg_hook_value            = var.secondary_asg_hook_value
  product                   = var.product
  asg_min_size              = 0
  asg_max_size              = 0
  asg_instance_count        = 0
  common_tags               = var.secondary_common_tags
}