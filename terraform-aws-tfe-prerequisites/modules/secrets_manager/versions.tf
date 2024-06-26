# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.55.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.5.1"
    }
  }
}
