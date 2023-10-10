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
