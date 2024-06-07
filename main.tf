#Certificate
module "tfe-cert" {
  source = "./supplemental-modules/generate-cert"

  route53_zone_name = "simon-lynch.sbx.hashidemos.io"
  cert_fqdn = "tfe.simon-lynch.sbx.hashidemos.io"
  region = "ap-southeast-2"
  email_address = "simon.lynch@hashicorp.com"

}


# Route53 Domain Name Generation
data "aws_route53_zone" "this" {
  name         = var.route53_zone_name
  private_zone = var.route53_private_zone
}

#aws eip
resource "aws_eip" "tfe" {
  domain = "vpc"
}


# Certificate Generation
module "acm" {
  source = "./terraform-aws-tfe-prerequisites/modules/ingress/modules/acm"

  domain_name               = "${var.route53_failover_record.record_name}.${var.route53_zone_name}"
  subject_alternative_names = []
  zone_id                   = data.aws_route53_zone.this.id
  validation_method         = var.acm_validation_method
}



# TFE AWS Pre-requisites
module "pre_req_primary" {
  source = "./terraform-aws-tfe-prerequisites"
  
    common_tags          = var.common_tags
    friendly_name_prefix = var.friendly_name_prefix
    product              = "tfefdo"
    tfe_active_active    = var.tfe_active_active

    create_vpc = true

    # * Collapsed deployment example. Because `database_subnets` is `[]` the redis and databases will be deployed on the private subnets with TFE
    database_subnets = []
    vpc_enable_ssm   = var.vpc_enable_ssm

    # Secrets Manager
    create_secrets         = true
    secretsmanager_secrets = var.secretsmanager_secrets

    # KMS
    create_kms = true

    # IAM
    create_iam_resources = true
    iam_resources        = var.iam_resources

    # S3
    create_s3_buckets = true
    s3_buckets        = var.s3_buckets

    # Logging
    create_log_group = true

    # Keypair
    create_ssh_keypair = var.create_ssh_keypair
    ssh_public_key     = var.ssh_public_key

    # Database
    create_db_cluster        = true
    create_db_global_cluster = false
    db_is_primary_cluster    = true
    db_instances             = 1 # Set to 1 to speed up examples. Should be a minimum of 2 when deploying in production
    db_username              = var.db_username
    db_password              = var.db_password
    db_database_name         = var.db_database_name

    # Load Balancer
    create_lb                 = false
    create_lb_security_groups = false
    create_lb_certificate     = false

    # Redis
    create_redis_replication_group = var.create_redis_replication_group
    redis_password                 = var.redis_password
}