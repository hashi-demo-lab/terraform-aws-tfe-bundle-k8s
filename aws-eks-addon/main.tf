locals {

  tags = {
    Blueprint = var.cluster_name
  }
}

module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0"

  cluster_name          = var.cluster_name
  cluster_endpoint      = var.cluster_endpoint
  cluster_version       = var.cluster_version
  oidc_provider_arn     = var.oidc_provider_arn
  enable_argo_workflows = false

  # We want to wait for the Fargate profiles to be deployed first
  #create_delay_dependencies = [for prof in module.eks.fargate_profiles : prof.fargate_profile_arn]

  # EKS Add-ons
  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    coredns = {
      most_recent = true

      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
  }


  # Enable Fargate logging
  enable_fargate_fluentbit            = false
  enable_external_dns                 = true
  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller = {
    set = [
      {
        name  = "vpcId"
        value = var.vpc_id
      },
      {
        name  = "podDisruptionBudget.maxUnavailable"
        value = 1
      },
    ]
  }

  tags = local.tags
}

#create tfe namespace
resource "kubernetes_namespace_v1" "name" {
  metadata {
    name = var.tfe_namespace
  } 
}

#create kubernetes service account
resource "kubernetes_service_account_v1" "tfe_service_account" {
  metadata {
    name      = var.tfe_service_account
    namespace = kubernetes_namespace_v1.name.metadata[0].name
  }
}

# Annotate the service account with the IAM role ARN
resource "kubernetes_annotations" "tfe_annotation" {
  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name = kubernetes_service_account_v1.tfe_service_account.metadata[0].name
    namespace = kubernetes_namespace_v1.name.metadata[0].name
  }
  annotations = {
    "eks.amazonaws.com/role-arn" = module.eks-blueprints-addon.iam_role_arn
  }
}

# Create IAM role for service account (IRSA) and attach TFE managed policy
module "eks-blueprints-addon" {
  source  = "aws-ia/eks-blueprints-addon/aws"
  version = "1.1.1"

  # Disable helm release
  create_release = false

  # IAM role for service account (IRSA)
  create_role = true
  role_name   = "${var.cluster_name}-tfe-sa-role"
  role_policies = {
    TFE_Role_Policy = var.iam_managed_policy_arn
  }

  oidc_providers = {
    this = {
      provider_arn    = var.oidc_provider_arn
      namespace       = kubernetes_namespace_v1.name.metadata[0].name
      service_account = kubernetes_service_account_v1.tfe_service_account.metadata[0].name
    }
  }

  tags = local.tags
}