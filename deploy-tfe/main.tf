locals {

   cert_pem_secret = base64encode(file(var.cert_pem_secret))
   cert_pem_private_key_secret = base64encode(file(var.cert_pem_private_key_secret))
   ca_certificate_bundle = base64encode(file(var.ca_certificate_bundle))
   tfe_license = file(var.tfe_license)


  tfe_config_yaml = templatefile("${path.module}/template/tfefdo.tpl", {
    TFE_DATABASE_PASSWORD                                   = var.db_password
    TFE_ENCRYPTION_PASSWORD                                 = var.tfe_encryption_password
    TFE_LICENSE                                             = local.tfe_license
    TFE_OBJECT_STORAGE_S3_SERVER_SIDE_ENCRYPTION_KMS_KEY_ID = var.kms_key_arn
    TFE_REDIS_PASSWORD                                      = var.redis_password
    TFE_CAPACITY_CONCURRENCY                                = var.tfe_capacity_concurrency
    TFE_DATABASE_HOST                                       = "${var.db_cluster_endpoint}:5432"
    TFE_DATABASE_NAME                                       = var.db_cluster_database_name
    TFE_DATABASE_PARAMETERS                                 = var.tfe_database_parameters
    TFE_DATABASE_USER                                       = var.tfe_database_user
    TFE_HOSTNAME                                            = var.tfe_hostname
    TFE_IACT_SUBNETS                                        = var.tfe_iact_subnets
    TFE_OBJECT_STORAGE_S3_BUCKET                            = var.s3_tfe_app_bucket_name
    TFE_OBJECT_STORAGE_S3_ENDPOINT                          = var.tfe_object_storage_s3_endpoint
    TFE_OBJECT_STORAGE_S3_REGION                            = var.region
    TFE_OBJECT_STORAGE_S3_SERVER_SIDE_ENCRYPTION            = var.tfe_object_storage_s3_server_side_encryption
    TFE_OBJECT_STORAGE_S3_USE_INSTANCE_PROFILE              = var.tfe_object_storage_s3_use_instance_profile
    TFE_OBJECT_STORAGE_TYPE                                 = var.tfe_object_storage_type
    TFE_REDIS_HOST                                          = var.redis_primary_endpoint
    TFE_REDIS_USE_AUTH                                      = var.tfe_redis_use_auth
    TFE_REDIS_USE_TLS                                       = var.tfe_redis_use_tls
    IMAGE_NAME                                              = "hashicorp/terraform-enterprise"
    IMAGE_REPOSITORY                                        = "images.releases.hashicorp.com"
    IMAGE_TAG                                               = var.image_tag
    REPLICA_COUNT                                           = var.replica_count
    SERVICE_TYPE                                            = var.service_type
    PRIVATE_HTTP_PORT                                       = "8080"
    PRIVATE_HTTPS_PORT                                      = "8081"
    TLS_CA_CERT_DATA                                        = local.ca_certificate_bundle
    TLS_CERT_DATA                                           = local.cert_pem_secret
    TLS_KEY_DATA                                            = local.cert_pem_private_key_secret
  })
}


resource local_file "tfe_config_yaml" {
  content  = local.tfe_config_yaml
  filename = "${path.module}/tfe_config.yaml"
}


output "tfe_config_yaml" {
  value = local.tfe_config_yaml
}