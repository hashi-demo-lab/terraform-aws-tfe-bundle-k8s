resource "local_file" "tfe_config_yaml" {
  content  = templatefile("${path.module}/tfe_config.tpl", {
    TFE_DATABASE_PASSWORD                                    = var.tfe_database_password
    TFE_ENCRYPTION_PASSWORD                                  = var.tfe_encryption_password
    TFE_LICENSE                                              = var.tfe_license
    TFE_OBJECT_STORAGE_S3_SERVER_SIDE_ENCRYPTION_KMS_KEY_ID  = var.tfe_object_storage_s3_server_side_encryption_kms_key_id
    TFE_REDIS_PASSWORD                                       = var.tfe_redis_password
    TFE_CAPACITY_CONCURRENCY                                 = var.tfe_capacity_concurrency
    TFE_DATABASE_HOST                                        = var.tfe_database_host
    TFE_DATABASE_NAME                                        = var.tfe_database_name
    TFE_DATABASE_PARAMETERS                                  = var.tfe_database_parameters
    TFE_DATABASE_USER                                        = var.tfe_database_user
    TFE_HOSTNAME                                             = var.tfe_hostname
    TFE_IACT_SUBNETS                                         = var.tfe_iact_subnets
    TFE_OBJECT_STORAGE_S3_BUCKET                             = var.tfe_object_storage_s3_bucket
    TFE_OBJECT_STORAGE_S3_ENDPOINT                           = var.tfe_object_storage_s3_endpoint
    TFE_OBJECT_STORAGE_S3_REGION                             = var.tfe_object_storage_s3_region
    TFE_OBJECT_STORAGE_S3_SERVER_SIDE_ENCRYPTION             = var.tfe_object_storage_s3_server_side_encryption
    TFE_OBJECT_STORAGE_S3_USE_INSTANCE_PROFILE               = var.tfe_object_storage_s3_use_instance_profile
    TFE_OBJECT_STORAGE_TYPE                                  = var.tfe_object_storage_type
    TFE_REDIS_HOST                                           = var.tfe_redis_host
    TFE_REDIS_USE_AUTH                                       = var.tfe_redis_use_auth
    TFE_REDIS_USE_TLS                                        = var.tfe_redis_use_tls
    IMAGE_NAME                                               = var.image_name
  })    
    filename = "${path.module}/tfe_config.yaml"

}