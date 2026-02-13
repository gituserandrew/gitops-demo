resource "google_compute_firewall" "local" {
  name    = "permit-local"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    local.public_subnet_cidr,
    local.private_subnet_cidr,
    local.secondary_pods_ip_range_cidr,
    local.secondary_services_ip_range_cidr
  ]
}

resource "google_compute_firewall" "gke" {
  name    = "permit-gke"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "health_check" {
  name    = "gcp-health-check"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
}

# resource "google_compute_firewall" "ssh" {
#   name    = "allow-ssh"
#   network = google_compute_network.vpc_network.name

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = [
#     "YOUR_PUBLIC_IP/32"
#   ]
# }


