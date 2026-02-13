resource "google_compute_subnetwork" "public" {
    project    = local.project_id
    name       = "public-subnet"
    ip_cidr_range = local.public_subnet_cidr
    region     = local.region
    network    = google_compute_network.vpc_network.id
    private_ip_google_access = true
    stack_type = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "private" {
    project    = local.project_id
    name       = "private-subnet"
    ip_cidr_range = local.private_subnet_cidr
    region     = local.region
    network    = google_compute_network.vpc_network.id
    private_ip_google_access = true
    stack_type = "IPV4_ONLY"

    secondary_ip_range {
      range_name = "kubernetes-pods"
      ip_cidr_range = local.secondary_pods_ip_range_cidr
    }

    secondary_ip_range {
      range_name = "kubernetes-services"
      ip_cidr_range = local.secondary_services_ip_range_cidr
    }
}

