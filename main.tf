#Certificate

module "tfe-cert" {
  source = "./supplemental-modules/generate-cert"

  route53_zone_name = "simon-lynch.sbx.hashidemos.io"
  cert_fqdn = "tfe.simon-lynch.sbx.hashidemos.io"
  region = "ap-southeast-2"
  email_address = "simon.lynch@hashicorp.com"

}