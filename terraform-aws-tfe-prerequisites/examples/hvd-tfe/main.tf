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
  create_lb_certificate     = false
  lb_type                   = var.lb_type
  route53_zone_name         = var.route53_zone_name
  route53_failover_record   = var.route53_failover_record
  lb_internal               = true

  lb_target_groups    = var.lb_target_groups
  lb_listener_details = var.lb_listener_details
  lb_sg_rules_details = var.lb_sg_rules_details

  #------------------------------------------------------------------------------
  # Redis
  #------------------------------------------------------------------------------
  create_redis_replication_group = var.create_redis_replication_group
  redis_password                 = var.redis_password
}
