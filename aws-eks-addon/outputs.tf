output "argo_workflows" {
  description = "Map of attributes of the Helm release created"
  value       = module.eks_blueprints_addons.argo_workflows
}

output "aws_load_balancer_controller" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.eks_blueprints_addons.aws_load_balancer_controller
}

output "eks_addons" {
  description = "Map of attributes for each EKS addons enabled"
  value       = module.eks_blueprints_addons.eks_addons
}

output "aws_external_dns" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.eks_blueprints_addons.external_dns
}

output "irsa_role_arn" {
  value = module.eks-blueprints-addon.iam_role_arn
  description = "role arn for tfe service account"
}


output "external_dns_irsa_role_arn" {
  value = module.eks_blueprints_addons.external_dns.iam_role_arn
  description = "ext dns role arn for tfe service account"
}

