terraform {
  required_version = "~> 1.7.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

provider "random" {
}

locals {
  region  = var.region
  project = var.project

  common_tags = {
    owner   = "asher_caley"
    purpose = "bigquery-remote-functions-poc"
  }
}