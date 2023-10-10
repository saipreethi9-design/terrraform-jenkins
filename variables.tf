variable "project" {
  description = "GCP project ID"
  default     = "jenkins-poc-400711"
}

variable "region" {
  description = "The Google Cloud region"
  default     = "us-east1"
}

variable "zone" {
  description = "The Google Cloud zone"
  default     = "us-east1-b"
}

variable "machine_type" {
  description = "The machine type for the Compute Engine instance"
  default     = "f1-micro"
}
