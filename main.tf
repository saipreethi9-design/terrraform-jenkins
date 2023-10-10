provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_project_service" "api" {
  for_each           = toset(var.service_list)
  disable_on_destroy = false
  service            = each.value
}

resource "google_compute_firewall" "web" {
  name          = "web-access"
  network       = "default"
  source_ranges = var.source_ranges

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

resource "google_compute_instance" "web_server" {
  name         = "gcp-web-server"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = "sudo apt update -y \n sudo apt install apache2 -y \n echo \"<h2>GCP WebServer Using Terraform!<h2>\"   >  /var/www/html/index.html \nsudo systemctl restart apache2 \n"
  depends_on              = [google_project_service.api, google_compute_firewall.web]
}
