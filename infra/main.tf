terraform {
  required_version = "~> 1.7.1"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

locals {
  region = var.region
  project = var.project

  common_tags = {
    Owner = "Asher"
    Purpose = "remote-function-testing"
  }
}