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

variable "service_list" {
  description = "A list of Google Cloud services to enable"
  type        = list(string)
  default = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
  ]
}

variable "source_ranges" {
  description = "The source IP ranges allowed for firewall rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "machine_type" {
  description = "The machine type for the Compute Engine instance"
  default     = "f1-micro"
}
