

provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "~> 1.7.1"

  required_providers {


    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }


}

