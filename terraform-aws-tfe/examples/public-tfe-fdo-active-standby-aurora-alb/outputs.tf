#------------------------------------------------------------------------------
# Active TFE
#------------------------------------------------------------------------------
output "primary_tfe_url" {
  value       = module.primary_tfe.tfe_url
  description = "URL of TFE application based on `route53_failover_fqdn` input."
}

output "primary_tfe_admin_console_url" {
  value       = module.primary_tfe.tfe_admin_console_url
  description = "URL of TFE (Replicated) Admin Console based on `route53_failover_fqdn` input."
}

output "primary_user_data_script" {
  value       = module.primary_tfe.user_data_script
  description = "base64 decoded user data script that is attached to the launch template"
  sensitive   = true
}

output "primary_launch_template_name" {
  value       = module.primary_tfe.launch_template_name
  description = "Name of the AWS launch template that was created during the run"
}

output "primary_asg_name" {
  value       = module.primary_tfe.asg_name
  description = "Name of the AWS autoscaling group that was created during the run."
}

output "primary_asg_healthcheck_type" {
  value       = module.primary_tfe.asg_healthcheck_type
  description = "Type of health check that is associated with the AWS autoscaling group."
}

output "primary_asg_target_group_arns" {
  value       = module.primary_tfe.asg_target_group_arns
  description = "List of the target group ARNs that are used for the AWS autoscaling group"
}

output "primary_security_group_ids" {
  value       = module.primary_tfe.security_group_ids
  description = "List of security groups that have been created during the run."
}


#------------------------------------------------------------------------------
# Standby TFE
#------------------------------------------------------------------------------
output "secondary_tfe_url" {
  value       = module.secondary_tfe.tfe_url
  description = "URL of TFE application based on `route53_failover_fqdn` input."
}

output "secondary_tfe_admin_console_url" {
  value       = module.secondary_tfe.tfe_admin_console_url
  description = "URL of TFE (Replicated) Admin Console based on `route53_failover_fqdn` input."
}

output "secondary_user_data_script" {
  value       = module.secondary_tfe.user_data_script
  description = "base64 decoded user data script that is attached to the launch template"
  sensitive   = true
}

output "secondary_launch_template_name" {
  value       = module.secondary_tfe.launch_template_name
  description = "Name of the AWS launch template that was created during the run"
}

output "secondary_asg_name" {
  value       = module.secondary_tfe.asg_name
  description = "Name of the AWS autoscaling group that was created during the run."
}

output "secondary_asg_healthcheck_type" {
  value       = module.secondary_tfe.asg_healthcheck_type
  description = "Type of health check that is associated with the AWS autoscaling group."
}

output "secondary_asg_target_group_arns" {
  value       = module.secondary_tfe.asg_target_group_arns
  description = "List of the target group ARNs that are used for the AWS autoscaling group"
}

output "secondary_security_group_ids" {
  value       = module.secondary_tfe.security_group_ids
  description = "List of security groups that have been created during the run."
}