variable "project" {
  description = "GCP project ID"
  default     = "jenkins-poc-400711"
}

variable "region" {
  description = "The Google Cloud region"
  default     = "us-central1"
}

variable "zone" {
  description = "The Google Cloud zone"
  default     = "us-central-a"
}

variable "machine_type" {
  description = "The machine type for the Compute Engine instance"
  default     = "e2-small"
}
