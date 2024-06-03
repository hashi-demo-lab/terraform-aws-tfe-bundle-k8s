locals {

   cert_pem_secret = file("/Users/simon.lynch/git/terraform-aws-tfe-bundle-k8s/files/tfe-no-root.pub")
   cert_pem_private_key_secret = file("/Users/simon.lynch/git/terraform-aws-tfe-bundle-k8s/files/tfe.key")
   ca_certificate_bundle = file("/Users/simon.lynch/git/terraform-aws-tfe-bundle-k8s/files/tfe.pub")
  

  tfe_config_yaml = templatefile("${path.module}/template/tfefdo.tpl", {
    TFE_DATABASE_PASSWORD                                   = var.tfe_database_password
    TFE_ENCRYPTION_PASSWORD                                 = var.tfe_encryption_password
    TFE_LICENSE                                             = var.tfe_license
    TFE_OBJECT_STORAGE_S3_SERVER_SIDE_ENCRYPTION_KMS_KEY_ID = var.tfe_kms_key_id
    TFE_REDIS_PASSWORD                                      = var.tfe_redis_password
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
    METRICS_ENABLE                                          = "true"
    METRICS_HTTP_PORT                                       = "9090"
    METRICS_HTTPS_PORT                                      = "9091"
    PRIVATE_HTTP_PORT                                       = "8080"
    PRIVATE_HTTPS_PORT                                      = "8081"
    TLS_CA_CERT_DATA                                        = locals.ca_certificate_bundle
    TLS_CERT_DATA                                           = locals.cert_pem_secret
    TLS_KEY_DATA                                            = locals.cert_pem_private_key_secret
  })


}