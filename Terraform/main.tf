terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.52.0"
    }
  }
}

provider "google" {
  # Config options
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}




module "gke_cluster" {
  source         = "github.com/nirev23/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = 2
}