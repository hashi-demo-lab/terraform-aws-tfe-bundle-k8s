module "pre_req_primary" {
  source = "../../"
  #------------------------------------------------------------------------------
  # General
  #------------------------------------------------------------------------------
  common_tags          = var.common_tags
  friendly_name_prefix = var.friendly_name_prefix
  product              = var.product
  tfe_active_active    = var.tfe_active_active
  #------------------------------------------------------------------------------
  # VPC
  #------------------------------------------------------------------------------
  create_vpc = true

  # * Collapsed deployment example. Because `database_subnets` is `[]` the redis and databases will be deployed on the private subnets with TFE
  database_subnets = []
  vpc_enable_ssm   = var.vpc_enable_ssm

  #------------------------------------------------------------------------------
  # Secrets Manager
  #------------------------------------------------------------------------------
  create_secrets         = true
  secretsmanager_secrets = var.secretsmanager_secrets

  #------------------------------------------------------------------------------
  # KMS
  #------------------------------------------------------------------------------
  create_kms = true

  #------------------------------------------------------------------------------
  # IAM
  #------------------------------------------------------------------------------
  create_iam_resources = true
  iam_resources        = var.iam_resources

  #------------------------------------------------------------------------------
  # S3
  #------------------------------------------------------------------------------
  create_s3_buckets = true
  s3_buckets        = var.s3_buckets

  #------------------------------------------------------------------------------
  # Logging
  #------------------------------------------------------------------------------
  create_log_group = true

  #------------------------------------------------------------------------------
  # Keypair
  #------------------------------------------------------------------------------
  create_ssh_keypair = var.create_ssh_keypair
  ssh_public_key     = var.ssh_public_key

  #------------------------------------------------------------------------------
  # Database
  #------------------------------------------------------------------------------
  create_db_cluster        = true
  create_db_global_cluster = false
  db_is_primary_cluster    = true
  db_instances             = 1 # Set to 1 to speed up examples. Should be a minimum of 2 when deploying in production
  db_username              = var.db_username
  db_password              = var.db_password
  db_database_name         = var.db_database_name

  #------------------------------------------------------------------------------
  # Load Balancer
  #------------------------------------------------------------------------------
  create_lb                 = true
  create_lb_security_groups = true
  create_lb_certificate     = true
  lb_type                   = var.lb_type
  route53_zone_name         = var.route53_zone_name
  route53_failover_record   = var.route53_failover_record
  lb_target_groups          = var.lb_target_groups
  lb_listener_details       = var.lb_listener_details
  lb_sg_rules_details       = var.lb_sg_rules_details
}


#------------------------------------------------------------------------------
# TFE Deployment (Testing)
#
# ASG will build when the pre_req database isn't totally ready.
# TFE will fail until then. If you want to bypass this add a depends_on in the
# Block below.
#
#  These modules weren't built with a single run in mind due to blast radius
#------------------------------------------------------------------------------

module "tfe" {
  depends_on                = [module.pre_req_primary]
  source                    = "../../../terraform-aws-tfe"
  permit_all_egress         = var.permit_all_egress
  friendly_name_prefix      = var.friendly_name_prefix
  tfe_fdo_release_sequence  = var.tfe_fdo_release_sequence
  ssh_key_pair              = module.pre_req_primary.ssh_keypair_name
  vpc_id                    = module.pre_req_primary.vpc_id
  tfe_hostname              = module.pre_req_primary.route53_failover_fqdn
  enable_active_active      = var.tfe_active_active
  iam_instance_profile      = module.pre_req_primary.iam_role_name
  kms_key_arn               = module.pre_req_primary.kms_key_alias_arn
  ec2_subnet_ids            = module.pre_req_primary.private_subnet_ids
  lb_tg_arns                = module.pre_req_primary.lb_tg_arns
  lb_type                   = module.pre_req_primary.lb_type
  lb_security_group_id      = one(module.pre_req_primary.lb_security_group_ids)
  s3_app_bucket_name        = module.pre_req_primary.s3_tfe_app_bucket_name
  s3_log_bucket_name        = module.pre_req_primary.s3_log_bucket_name
  log_forwarding_enabled    = var.log_forwarding_enabled
  log_forwarding_type       = var.log_forwarding_type
  cloudwatch_log_group_name = module.pre_req_primary.cloudwatch_log_group_name
  tfe_secrets_arn           = module.pre_req_primary.tfe_secrets_arn
  tfe_cert_secret_arn       = module.pre_req_primary.cert_pem_secret_arn
  tfe_privkey_secret_arn    = module.pre_req_primary.cert_pem_private_key_secret_arn
  ca_bundle_secret_arn      = module.pre_req_primary.ca_certificate_bundle_secret_arn
  db_username               = module.pre_req_primary.db_username
  db_password               = module.pre_req_primary.db_password
  db_database_name          = module.pre_req_primary.db_cluster_database_name
  db_cluster_endpoint       = module.pre_req_primary.db_cluster_endpoint
  asg_hook_value            = module.pre_req_primary.asg_hook_value
  product                   = var.product
  asg_min_size              = 1
  asg_instance_count        = 1
  asg_max_size              = 1
}

