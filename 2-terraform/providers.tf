terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.14.1"
    }
  }
}

provider "google" {
  # Configuration options
  project     = local.project_id
  region      = local.region
}


