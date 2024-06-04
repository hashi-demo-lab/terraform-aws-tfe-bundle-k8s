cat "/Users/simon.lynch/git/terraform-aws-tfe-bundle-k8s/files/terraform.hclic" |  docker login --username terraform images.releases.hashicorp.com --password-stdin


kubectl create secret docker-registry terraform-enterprise --docker-server=images.releases.hashicorp.com --docker-username=terraform --docker-password=$(cat /Users/simon.lynch/git/terraform-aws-tfe-bundle-k8s/files/terraform.hclic) -n tfe

helm repo add hashicorp https://helm.releases.hashicorp.com

helm template terraform-enterprise hashicorp/terraform-enterprise --namespace tfe --values tfe_config.yaml

helm install --version v1.2.0 terraform-enterprise hashicorp/terraform-enterprise --namespace tfe --values tfe_config.yaml


# Debug

kubectl logs terraform-enterprise-b98dbb984-k65s7 --all-containers -n tfe
kubectl logs terraform-enterprise-b98dbb984-l8fwr --all-containers -n tfe


kubectl logs terraform-enterprise-b98dbb984-4qswd --all-containers -n tfe
kubectl logs terraform-enterprise-b98dbb984-k4rk5 --all-containers -n tfe


kubectl logs terraform-enterprise-d8f86b689-cqjv7 --all-containers -n tfe -f
kubectl logs terraform-enterprise-d8f86b689-78dxn --all-containers -n tfe -f

terraform-enterprise-d8f86b689-cqjv7   0/1     Running   0          29s
terraform-enterprise-d8f86b689-hjmc6   0/1     Running   0          29s