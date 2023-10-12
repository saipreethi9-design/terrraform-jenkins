variable "project" {
  description = "GCP project ID"
}

variable "region" {
  description = "The Google Cloud region"
  default     = "us-central1"
}

variable "zone" {
  description = "The Google Cloud zone"
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "The machine type for the Compute Engine instance"
  default     = "e2-small"
}
