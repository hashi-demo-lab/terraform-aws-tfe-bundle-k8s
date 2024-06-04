cat "/Users/simon.lynch/git/terraform-aws-tfe-bundle-k8s/files/terraform.hclic" |  docker login --username terraform images.releases.hashicorp.com --password-stdin


kubectl create secret docker-registry terraform-enterprise --docker-server=images.releases.hashicorp.com --docker-username=terraform --docker-password=$(cat /Users/simon.lynch/git/terraform-aws-tfe-bundle-k8s/files/terraform.hclic) -n tfefdo

helm repo add hashicorp https://helm.releases.hashicorp.com

helm template terraform-enterprise hashicorp/terraform-enterprise --namespace tfe --values tfe_config.yaml

helm install terraform-enterprise hashicorp/terraform-enterprise --namespace tfe --values tfe_config.yaml
