variable "GOOGLE_PROJECT" {
  type        = string
  default     = "devops-391113"
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "g1-small"
  description = "Machine type"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = "2"
  description = "GKE nodes number"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "main"
  description = "GKE cluster name"
}

variable "GKE_POOL_NAME" {
  type        = string
  default     = "main"
  description = "GKE pool name"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-git2"
  description = "Flux Git repo"
}

variable "FLUX_GITHUB_TARGET_PATH" {
  type        = string
  default     = "clusters"
  description = "Flux manifests subdirectory"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "Github owner repo"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "Github access token"
}