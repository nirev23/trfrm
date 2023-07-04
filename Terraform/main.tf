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
  GKE_NUM_NODES  = var.GKE_NUM_NODES
}

module "github-repository" {
  source                   = "github.com/den-vasyliev/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "flux_bootstrap" {
  source            = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_path       = module.gke_cluster.kubeconfig
  github_token      = var.GITHUB_TOKEN
}

module "tls_private_key" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
}

module "gke-workload-identity" {
    source = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
    use_existing_k8s_sa = true
    name =  "kustomize-controller"
    namespace  = "flux-system"
    project_id  = var.GOOGLE_PROJECT
    cluster_name = "main"
    location = var.GOOGLE_REGION
    annotate_k8s_sa = true
    roles = ["roles/cloudkms.cryptoKeyEncrypterDecrypter"]
}

module "kms" {
    source = "github.com/den-vasyliev/terraform-google-kms"
    project_id  = var.GOOGLE_PROJECT
    keyring = "sops-flux"
    location = "global"
    keys = ["sops-key-flux"]
    prevent_destroy = false
}
