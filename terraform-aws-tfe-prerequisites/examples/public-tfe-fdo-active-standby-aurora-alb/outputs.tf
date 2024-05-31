#------------------------------------------------------------------------------
# Network
#------------------------------------------------------------------------------
output "primary_vpc_id" {
  description = "The ID of the VPC"
  value       = module.pre_req_primary.vpc_id
}

output "primary_region" {
  description = "The AWS region where the resources have been created"
  value       = module.pre_req_primary.region
}

output "primary_vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.pre_req_primary.vpc_arn
}

output "primary_vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.pre_req_primary.vpc_cidr_block
}

output "primary_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.pre_req_primary.default_security_group_id
}

output "primary_private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.pre_req_primary.private_subnet_ids
}

output "primary_private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.pre_req_primary.private_subnet_arns
}

output "primary_private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.pre_req_primary.private_subnets_cidr_blocks
}

output "primary_private_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = module.pre_req_primary.private_subnets_ipv6_cidr_blocks
}

output "primary_public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.pre_req_primary.public_subnet_ids
}

output "primary_public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.pre_req_primary.public_subnet_arns
}

output "primary_public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.pre_req_primary.public_subnets_cidr_blocks
}

output "primary_public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = module.pre_req_primary.public_subnets_ipv6_cidr_blocks
}

output "primary_public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.pre_req_primary.public_route_table_ids
}

output "primary_private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.pre_req_primary.private_route_table_ids
}

output "primary_db_subnet_ids" {
  description = "List of IDs of database subnets"
  value       = module.pre_req_primary.db_subnet_ids
}

output "primary_db_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = module.pre_req_primary.db_subnet_arns
}

output "primary_db_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.pre_req_primary.db_subnets_cidr_blocks
}

output "primary_db_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of database subnets in an IPv6 enabled VPC"
  value       = module.pre_req_primary.db_subnets_ipv6_cidr_blocks
}

output "primary_db_subnet_group" {
  description = "ID of database subnet group"
  value       = module.pre_req_primary.db_subnet_group
}

output "primary_db_subnet_group_name" {
  description = "Name of database subnet group"
  value       = module.pre_req_primary.db_subnet_group_name
}

output "secondary_vpc_id" {
  description = "The ID of the VPC"
  value       = module.pre_req_secondary.vpc_id
}

output "secondary_region" {
  description = "The AWS region where the resources have been created"
  value       = module.pre_req_secondary.region
}

output "secondary_vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.pre_req_secondary.vpc_arn
}

output "secondary_vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.pre_req_secondary.vpc_cidr_block
}

output "secondary_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.pre_req_secondary.default_security_group_id
}

output "secondary_private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.pre_req_secondary.private_subnet_ids
}

output "secondary_private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.pre_req_secondary.private_subnet_arns
}

output "secondary_private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.pre_req_secondary.private_subnets_cidr_blocks
}

output "secondary_private_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = module.pre_req_secondary.private_subnets_ipv6_cidr_blocks
}

output "secondary_public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.pre_req_secondary.public_subnet_ids
}

output "secondary_public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.pre_req_secondary.public_subnet_arns
}

output "secondary_public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.pre_req_secondary.public_subnets_cidr_blocks
}

output "secondary_public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = module.pre_req_secondary.public_subnets_ipv6_cidr_blocks
}

output "secondary_public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.pre_req_secondary.public_route_table_ids
}

output "secondary_private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.pre_req_secondary.private_route_table_ids
}

output "secondary_db_subnet_ids" {
  description = "List of IDs of database subnets"
  value       = module.pre_req_secondary.db_subnet_ids
}

output "secondary_db_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = module.pre_req_secondary.db_subnet_arns
}

output "secondary_db_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.pre_req_secondary.db_subnets_cidr_blocks
}

output "secondary_db_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of database subnets in an IPv6 enabled VPC"
  value       = module.pre_req_secondary.db_subnets_ipv6_cidr_blocks
}

output "secondary_db_subnet_group" {
  description = "ID of database subnet group"
  value       = module.pre_req_secondary.db_subnet_group
}

output "secondary_db_subnet_group_name" {
  description = "Name of database subnet group"
  value       = module.pre_req_secondary.db_subnet_group_name
}

#------------------------------------------------------------------------------
# S3
#------------------------------------------------------------------------------

output "primary_s3_bucket_arn_list" {
  value       = module.pre_req_primary.s3_bucket_arn_list
  description = "A list of the ARNs for the buckets that have been configured"
}

output "primary_s3_replication_iam_role_arn" {
  value       = module.pre_req_primary.s3_replication_iam_role_arn
  description = "ARN of IAM Role for S3 replication."
}

output "primary_s3_bootstrap_bucket_name" {
  value       = module.pre_req_primary.s3_bootstrap_bucket_name
  description = "Name of S3 'bootstrap' bucket."
}

output "primary_s3_bootstrap_bucket_arn" {
  value       = module.pre_req_primary.s3_bootstrap_bucket_arn
  description = "ARN of S3 'bootstrap' bucket"
}

output "primary_s3_bootstrap_bucket_replication_policy" {
  value       = module.pre_req_primary.s3_bootstrap_bucket_replication_policy
  description = "Replication policy of the S3 'bootstrap' bucket."
}

output "primary_s3_log_bucket_name" {
  value       = module.pre_req_primary.s3_log_bucket_name
  description = "Name of S3 'logging' bucket."
}

output "primary_s3_log_bucket_arn" {
  value       = module.pre_req_primary.s3_log_bucket_arn
  description = "Name of S3 'logging' bucket."
}

output "primary_s3_log_bucket_replication_policy" {
  value       = module.pre_req_primary.s3_log_bucket_replication_policy
  description = "Replication policy of the S3 'logging' bucket."
}

output "primary_s3_tfe_app_bucket_name" {
  value       = module.pre_req_primary.s3_tfe_app_bucket_name
  description = "Name of S3 S3 Terraform Enterprise Object Store bucket."
}

output "primary_s3_tfe_app_bucket_arn" {
  value       = module.pre_req_primary.s3_tfe_app_bucket_arn
  description = "ARN of the S3 Terraform Enterprise Object Store bucket."
}

output "primary_s3_tfe_app_bucket_replication_policy" {
  value       = module.pre_req_primary.s3_tfe_app_bucket_replication_policy
  description = "Replication policy of the S3 Terraform Enterprise Object Store bucket."
}


output "secondary_s3_bucket_arn_list" {
  value       = module.pre_req_secondary.s3_bucket_arn_list
  description = "A list of the ARNs for the buckets that have been configured"
}

output "secondary_s3_replication_iam_role_arn" {
  value       = module.pre_req_secondary.s3_replication_iam_role_arn
  description = "ARN of IAM Role for S3 replication."
}

output "secondary_s3_bootstrap_bucket_name" {
  value       = module.pre_req_secondary.s3_bootstrap_bucket_name
  description = "Name of S3 'bootstrap' bucket."
}

output "secondary_s3_bootstrap_bucket_arn" {
  value       = module.pre_req_secondary.s3_bootstrap_bucket_arn
  description = "ARN of S3 'bootstrap' bucket"
}

output "secondary_s3_bootstrap_bucket_replication_policy" {
  value       = module.pre_req_secondary.s3_bootstrap_bucket_replication_policy
  description = "Replication policy of the S3 'bootstrap' bucket."
}

output "secondary_s3_log_bucket_name" {
  value       = module.pre_req_secondary.s3_log_bucket_name
  description = "Name of S3 'logging' bucket."
}

output "secondary_s3_log_bucket_arn" {
  value       = module.pre_req_secondary.s3_log_bucket_arn
  description = "Name of S3 'logging' bucket."
}

output "secondary_s3_log_bucket_replication_policy" {
  value       = module.pre_req_secondary.s3_log_bucket_replication_policy
  description = "Replication policy of the S3 'logging' bucket."
}

output "secondary_s3_tfe_app_bucket_name" {
  value       = module.pre_req_secondary.s3_tfe_app_bucket_name
  description = "Name of S3 S3 Terraform Enterprise Object Store bucket."
}

output "secondary_s3_tfe_app_bucket_arn" {
  value       = module.pre_req_secondary.s3_tfe_app_bucket_arn
  description = "ARN of the S3 Terraform Enterprise Object Store bucket."
}

output "secondary_s3_tfe_app_bucket_replication_policy" {
  value       = module.pre_req_secondary.s3_tfe_app_bucket_replication_policy
  description = "Replication policy of the S3 Terraform Enterprise Object Store bucket."
}


#------------------------------------------------------------------------------
# KMS
#------------------------------------------------------------------------------
output "primary_kms_key_arn" {
  value       = module.pre_req_primary.kms_key_arn
  description = "The KMS key used to encrypt data."
}

output "primary_kms_key_alias" {
  value       = module.pre_req_primary.kms_key_alias
  description = "The KMS Key Alias"
}

output "primary_kms_key_alias_arn" {
  value       = module.pre_req_primary.kms_key_alias_arn
  description = "The KMS Key Alias arn"
}

output "secondary_kms_key_arn" {
  value       = module.pre_req_secondary.kms_key_arn
  description = "The KMS key used to encrypt data."
}

output "secondary_kms_key_alias" {
  value       = module.pre_req_secondary.kms_key_alias
  description = "The KMS Key Alias"
}

output "secondary_kms_key_alias_arn" {
  value       = module.pre_req_secondary.kms_key_alias_arn
  description = "The KMS Key Alias arn"
}
#------------------------------------------------------------------------------
# Secrets Manager
#------------------------------------------------------------------------------
output "primary_replicated_license_secret_arn" {
  value       = module.pre_req_primary.replicated_license_secret_arn
  description = "AWS Secrets Manager license secret ARN."
}

output "primary_tfe_secrets_arn" {
  value       = module.pre_req_primary.tfe_secrets_arn
  description = "AWS Secrets Manager `tfe` secrets ARN."
}

output "primary_ca_certificate_bundle_secret_arn" {
  value       = module.pre_req_primary.ca_certificate_bundle_secret_arn
  description = "AWS Secrets Manager TFE BYO CA certificate secret ARN."
}

output "primary_cert_pem_secret_arn" {
  value       = module.pre_req_primary.cert_pem_secret_arn
  description = "AWS Secrets Manager TFE BYO CA certificate private key secret ARN."
}

output "primary_cert_pem_private_key_secret_arn" {
  value       = module.pre_req_primary.cert_pem_private_key_secret_arn
  description = "AWS Secrets Manager TFE BYO CA certificate private key secret ARN."
}

output "primary_secret_arn_list" {
  value       = module.pre_req_primary.secret_arn_list
  description = "A list of AWS Secrets Manager Arns produced by the module"
}

output "secondary_replicated_license_secret_arn" {
  value       = module.pre_req_secondary.replicated_license_secret_arn
  description = "AWS Secrets Manager license secret ARN."
}

output "secondary_tfe_secrets_arn" {
  value       = module.pre_req_secondary.tfe_secrets_arn
  description = "AWS Secrets Manager `tfe` secrets ARN."
}

output "secondary_ca_certificate_bundle_secret_arn" {
  value       = module.pre_req_secondary.ca_certificate_bundle_secret_arn
  description = "AWS Secrets Manager TFE BYO CA certificate secret ARN."
}

output "secondary_cert_pem_secret_arn" {
  value       = module.pre_req_secondary.cert_pem_secret_arn
  description = "AWS Secrets Manager TFE BYO CA certificate private key secret ARN."
}

output "secondary_cert_pem_private_key_secret_arn" {
  value       = module.pre_req_secondary.cert_pem_private_key_secret_arn
  description = "AWS Secrets Manager TFE BYO CA certificate private key secret ARN."
}

output "secondary_secret_arn_list" {
  value       = module.pre_req_secondary.secret_arn_list
  description = "A list of AWS Secrets Manager Arns produced by the module"
}

#------------------------------------------------------------------------------
# CloudWatch
#------------------------------------------------------------------------------
output "primary_cloudwatch_log_group_name" {
  value       = module.pre_req_primary.cloudwatch_log_group_name
  description = "AWS CloudWatch Log Group Name."
}

output "secondary_cloudwatch_log_group_name" {
  value       = module.pre_req_secondary.cloudwatch_log_group_name
  description = "AWS CloudWatch Log Group Name."
}

#------------------------------------------------------------------------------
# TFE Key Pair
#------------------------------------------------------------------------------
output "primary_ssh_keypair_name" {
  value       = module.pre_req_primary.ssh_keypair_name
  description = "Name of the keypair that was created (if specified)."
}

output "primary_ssh_keypair_arn" {
  value       = module.pre_req_primary.ssh_keypair_arn
  description = "ARN of the keypair that was created (if specified)."
}

output "primary_ssh_keypair_id" {
  value       = module.pre_req_primary.ssh_keypair_id
  description = "ID of TFE SSH Key Pair."
}

output "primary_ssh_keypair_fingerprint" {
  value       = module.pre_req_primary.ssh_keypair_fingerprint
  description = "Fingerprint of TFE SSH Key Pair."
}

output "secondary_ssh_keypair_name" {
  value       = module.pre_req_secondary.ssh_keypair_name
  description = "Name of the keypair that was created (if specified)."
}

output "secondary_ssh_keypair_arn" {
  value       = module.pre_req_secondary.ssh_keypair_arn
  description = "ARN of the keypair that was created (if specified)."
}

output "secondary_ssh_keypair_id" {
  value       = module.pre_req_secondary.ssh_keypair_id
  description = "ID of TFE SSH Key Pair."
}

output "secondary_ssh_keypair_fingerprint" {
  value       = module.pre_req_secondary.ssh_keypair_fingerprint
  description = "Fingerprint of TFE SSH Key Pair."
}


#------------------------------------------------------------------------------
# Databases
#------------------------------------------------------------------------------

output "primary_db_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.pre_req_primary.db_cluster_arn
}

output "primary_db_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.pre_req_primary.db_cluster_id
}

output "primary_db_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.pre_req_primary.db_cluster_resource_id
}

output "primary_db_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.pre_req_primary.db_cluster_members
}

output "primary_db_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.pre_req_primary.db_cluster_endpoint
}

output "primary_db_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.pre_req_primary.db_cluster_reader_endpoint
}

output "primary_db_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.pre_req_primary.db_cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "primary_db_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.pre_req_primary.db_cluster_database_name
}

output "primary_db_cluster_port" {
  description = "The database port"
  value       = module.pre_req_primary.db_cluster_port
}

output "primary_db_password" {
  description = "The database master password"
  value       = module.pre_req_primary.db_password
  sensitive   = true
}

output "primary_db_username" {
  description = "The database master username"
  value       = module.pre_req_primary.db_username
  sensitive   = true
}

output "primary_db_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.pre_req_primary.db_cluster_instances
}

output "primary_db_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.pre_req_primary.db_additional_cluster_endpoints
}

output "primary_db_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.pre_req_primary.db_cluster_role_associations
}

output "primary_db_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.pre_req_primary.db_enhanced_monitoring_iam_role_name
}

output "primary_db_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.pre_req_primary.db_enhanced_monitoring_iam_role_arn
}

output "primary_db_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.pre_req_primary.db_enhanced_monitoring_iam_role_unique_id
}

output "primary_db_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.pre_req_primary.db_security_group_id
}

output "primary_db_global_cluster_id" {
  description = "ID of the global cluster that has been created (if specified.)"
  value       = module.pre_req_primary.db_global_cluster_id
}

output "primary_db_cluster_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.pre_req_primary.db_cluster_cloudwatch_log_groups
}

output "secondary_db_cluster_arn" {
  description = "Amazon Resource Name (ARN) of cluster"
  value       = module.pre_req_secondary.db_cluster_arn
}

output "secondary_db_cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.pre_req_secondary.db_cluster_id
}

output "secondary_db_cluster_resource_id" {
  description = "The RDS Cluster Resource ID"
  value       = module.pre_req_secondary.db_cluster_resource_id
}

output "secondary_db_cluster_members" {
  description = "List of RDS Instances that are a part of this cluster"
  value       = module.pre_req_secondary.db_cluster_members
}

output "secondary_db_cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.pre_req_secondary.db_cluster_endpoint
}

output "secondary_db_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.pre_req_secondary.db_cluster_reader_endpoint
}

output "secondary_db_cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value       = module.pre_req_secondary.db_cluster_engine_version_actual
}

# database_name is not set on `aws_rds_cluster` resource if it was not specified, so can't be used in output
output "secondary_db_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.pre_req_secondary.db_cluster_database_name
}

output "secondary_db_cluster_port" {
  description = "The database port"
  value       = module.pre_req_secondary.db_cluster_port
}

output "secondary_db_password" {
  description = "The database master password"
  value       = module.pre_req_secondary.db_password
  sensitive   = true
}

output "secondary_db_username" {
  description = "The database master username"
  value       = module.pre_req_secondary.db_username
  sensitive   = true
}

output "secondary_db_cluster_instances" {
  description = "A map of cluster instances and their attributes"
  value       = module.pre_req_secondary.db_cluster_instances
}

output "secondary_db_additional_cluster_endpoints" {
  description = "A map of additional cluster endpoints and their attributes"
  value       = module.pre_req_secondary.db_additional_cluster_endpoints
}

output "secondary_db_cluster_role_associations" {
  description = "A map of IAM roles associated with the cluster and their attributes"
  value       = module.pre_req_secondary.db_cluster_role_associations
}

output "secondary_db_enhanced_monitoring_iam_role_name" {
  description = "The name of the enhanced monitoring role"
  value       = module.pre_req_secondary.db_enhanced_monitoring_iam_role_name
}

output "secondary_db_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the enhanced monitoring role"
  value       = module.pre_req_secondary.db_enhanced_monitoring_iam_role_arn
}

output "secondary_db_enhanced_monitoring_iam_role_unique_id" {
  description = "Stable and unique string identifying the enhanced monitoring role"
  value       = module.pre_req_secondary.db_enhanced_monitoring_iam_role_unique_id
}

output "secondary_db_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.pre_req_secondary.db_security_group_id
}

output "secondary_db_global_cluster_id" {
  description = "ID of the global cluster that has been created (if specified.)"
  value       = module.pre_req_secondary.db_global_cluster_id
}

output "secondary_db_cluster_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.pre_req_secondary.db_cluster_cloudwatch_log_groups
}

#------------------------------------------------------------------------------
# TFE IAM Resources
#------------------------------------------------------------------------------
output "primary_iam_role_arn" {
  value       = module.pre_req_primary.iam_role_arn
  description = "ARN of IAM Role in use by TFE Instances"
}

output "primary_iam_role_name" {
  value       = module.pre_req_primary.iam_role_name
  description = "Name of IAM Role in use by TFE Instances"
}

output "primary_iam_managed_policy_arn" {
  value       = module.pre_req_primary.iam_managed_policy_arn
  description = "ARN of IAM Managed Policy for TFE Instance Role"
}

output "primary_iam_managed_policy_name" {
  value       = module.pre_req_primary.iam_managed_policy_name
  description = "Name of IAM Managed Policy for TFE Instance Role"
}

output "primary_iam_instance_profile" {
  value       = module.pre_req_primary.iam_instance_profile
  description = "ARN of IAM Instance Profile for TFE Instance Role"
}

output "secondary_iam_role_arn" {
  value       = module.pre_req_secondary.iam_role_arn
  description = "ARN of IAM Role in use by TFE Instances"
}

output "secondary_iam_role_name" {
  value       = module.pre_req_secondary.iam_role_name
  description = "Name of IAM Role in use by TFE Instances"
}

output "secondary_iam_managed_policy_arn" {
  value       = module.pre_req_secondary.iam_managed_policy_arn
  description = "ARN of IAM Managed Policy for TFE Instance Role"
}

output "secondary_iam_managed_policy_name" {
  value       = module.pre_req_secondary.iam_managed_policy_name
  description = "Name of IAM Managed Policy for TFE Instance Role"
}

output "secondary_iam_instance_profile" {
  value       = module.pre_req_secondary.iam_instance_profile
  description = "ARN of IAM Instance Profile for TFE Instance Role"
}

#------------------------------------------------------------------------------
# TFE Ingress Resources
#------------------------------------------------------------------------------
output "primary_lb_arn" {
  value       = module.pre_req_primary.lb_arn
  description = "The Resource Identifier of the LB"
}

output "primary_lb_name" {
  value       = module.pre_req_primary.lb_name
  description = "Name of the LB"
}

output "primary_lb_dns_name" {
  value       = module.pre_req_primary.lb_dns_name
  description = "The DNS name created with the LB"
}

output "primary_lb_zone_id" {
  value       = module.pre_req_primary.lb_zone_id
  description = "The Zone ID of the LB"
}

output "primary_lb_internal" {
  value       = module.pre_req_primary.lb_internal
  description = "Boolean value of the internal/external status of the LB.  Determines if the LB gets Elastic IPs assigned"
}

output "primary_lb_security_group_ids" {
  value       = module.pre_req_primary.lb_security_group_ids
  description = "List of security group IDs in use by the LB"
}

output "primary_lb_tg_arns" {
  value       = module.pre_req_primary.lb_tg_arns
  description = "List of target group ARNs for LB"
}

output "primary_lb_type" {
  value       = module.pre_req_primary.lb_type
  description = "Type of LB created (ALB or NLB)"
}

output "primary_acm_certificate_arn" {
  value       = module.pre_req_primary.acm_certificate_arn
  description = "The ARN of the certificate"
}

output "primary_acm_certificate_status" {
  value       = module.pre_req_primary.acm_certificate_status
  description = "Status of the certificate"
}

output "primary_acm_distinct_domain_names" {
  value       = module.pre_req_primary.acm_distinct_domain_names
  description = "List of distinct domains names used for the validation"
}

output "primary_acm_validation_domains" {
  value       = module.pre_req_primary.acm_validation_domains
  description = "List of distinct domain validation options. This is useful if subject alternative names contain wildcards"
}

output "primary_acm_validation_route53_record_fqdns" {
  value       = module.pre_req_primary.acm_validation_route53_record_fqdns
  description = "List of FQDNs built using the zone domain and name"
}

output "primary_route53_regional_record_name" {
  value       = module.pre_req_primary.route53_regional_record_name
  description = "Name of the regional LB Route53 record name"
}

output "primary_route53_regional_fqdn" {
  value       = module.pre_req_primary.route53_regional_fqdn
  description = "FQDN of regional LB Route53 record"
}

output "primary_route53_failover_record_name" {
  value       = module.pre_req_primary.route53_failover_record_name
  description = "Name of the failover LB Route53 record name"
}

output "primary_route53_failover_fqdn" {
  value       = module.pre_req_primary.route53_failover_fqdn
  description = "FQDN of failover LB Route53 record"
}

output "primary_asg_hook_value" {
  value       = module.pre_req_primary.asg_hook_value
  description = "Value for the `asg-hook` tag that will be attatched to the TFE instance in the other module. Use this value to ensure the lifecycle hook is updated during deployment."
}

output "secondary_lb_arn" {
  value       = module.pre_req_secondary.lb_arn
  description = "The Resource Identifier of the LB"
}

output "secondary_lb_name" {
  value       = module.pre_req_secondary.lb_name
  description = "Name of the LB"
}

output "secondary_lb_dns_name" {
  value       = module.pre_req_secondary.lb_dns_name
  description = "The DNS name created with the LB"
}

output "secondary_lb_zone_id" {
  value       = module.pre_req_secondary.lb_zone_id
  description = "The Zone ID of the LB"
}

output "secondary_lb_internal" {
  value       = module.pre_req_secondary.lb_internal
  description = "Boolean value of the internal/external status of the LB.  Determines if the LB gets Elastic IPs assigned"
}

output "secondary_lb_security_group_ids" {
  value       = module.pre_req_secondary.lb_security_group_ids
  description = "List of security group IDs in use by the LB"
}

output "secondary_lb_tg_arns" {
  value       = module.pre_req_secondary.lb_tg_arns
  description = "List of target group ARNs for LB"
}

output "secondary_lb_type" {
  value       = module.pre_req_secondary.lb_type
  description = "Type of LB created (ALB or NLB)"
}

output "secondary_acm_certificate_arn" {
  value       = module.pre_req_secondary.acm_certificate_arn
  description = "The ARN of the certificate"
}

output "secondary_acm_certificate_status" {
  value       = module.pre_req_secondary.acm_certificate_status
  description = "Status of the certificate"
}

output "secondary_acm_distinct_domain_names" {
  value       = module.pre_req_secondary.acm_distinct_domain_names
  description = "List of distinct domains names used for the validation"
}

output "secondary_acm_validation_domains" {
  value       = module.pre_req_secondary.acm_validation_domains
  description = "List of distinct domain validation options. This is useful if subject alternative names contain wildcards"
}

output "secondary_acm_validation_route53_record_fqdns" {
  value       = module.pre_req_secondary.acm_validation_route53_record_fqdns
  description = "List of FQDNs built using the zone domain and name"
}

output "secondary_route53_regional_record_name" {
  value       = module.pre_req_secondary.route53_regional_record_name
  description = "Name of the regional LB Route53 record name"
}

output "secondary_route53_regional_fqdn" {
  value       = module.pre_req_secondary.route53_regional_fqdn
  description = "FQDN of regional LB Route53 record"
}

output "secondary_route53_failover_record_name" {
  value       = module.pre_req_secondary.route53_failover_record_name
  description = "Name of the failover LB Route53 record name"
}

output "secondary_route53_failover_fqdn" {
  value       = module.pre_req_secondary.route53_failover_fqdn
  description = "FQDN of failover LB Route53 record"
}

output "secondary_asg_hook_value" {
  value       = module.pre_req_secondary.asg_hook_value
  description = "Value for the `asg-hook` tag that will be attatched to the TFE instance in the other module. Use this value to ensure the lifecycle hook is updated during deployment."
}
