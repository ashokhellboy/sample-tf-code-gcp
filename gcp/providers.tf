terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.8.0"
    }
  }
}

  provider "google" {
  project = "bullitt-customer-portal"
  region  = "us-central1"
  zone    = "us-central1-c"
}
