resource "google_compute_network" "vpc_network" {
  project                 = local.project_id
  name                    = "golang-vpc-network"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true

  depends_on = [ google_project_service.enable_apis ]
}

resource "google_compute_route" "default_route" {
  project = local.project_id
  name    = "default-internet-route"
  network = google_compute_network.vpc_network.name
  next_hop_gateway = "default-internet-gateway"

  dest_range = "0.0.0.0/0"
  
}

