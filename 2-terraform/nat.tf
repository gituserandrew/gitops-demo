resource "google_compute_address" "nat" {
  name = "nat-gateway"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [ google_project_service.enable_apis ]
}

resource "google_compute_router" "router" {
    name    = "nat-router"
    network = google_compute_network.vpc_network.id
    region  = local.region
    project = local.project_id
    depends_on = [ google_project_service.enable_apis ]
}

resource "google_compute_router_nat" "nat_router" {
  name = "nat-router"
  router = google_compute_router.router.name
  region = local.region
  project = local.project_id
  nat_ip_allocate_option = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ips = [ google_compute_address.nat.self_link ]

  subnetwork {
    name = google_compute_subnetwork.private.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


