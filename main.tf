provider "google" {
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "web_server" {
  name         = "gcp-web-server"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_artifact_registry_repository" "web_server_repository" {
  repository_id   = "terraform-jenkins-repo"
  location        = var.region
  project         = var.project
  format          = "DOCKER"
  description     = "Artifact Registry repository for the web server"
}
