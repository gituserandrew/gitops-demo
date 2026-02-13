resource "google_service_account" "gke_sa" {
    account_id   = "gke-service-account"
    display_name = "GKE Service Account"
}

resource "google_project_iam_member" "gke_logging" {
    project = local.project_id
    role    = "roles/logging.logWriter"
    member  = "serviceAccount:${google_service_account.gke_sa.email}"
  
}

resource "google_project_iam_member" "gke_monitoring" {
    project = local.project_id
    role    = "roles/monitoring.metricWriter"
    member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_container_node_pool" "gke_node_pool" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = "us-central1-a"
  initial_node_count = 1

  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 3
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20
    disk_type = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    service_account = google_service_account.gke_sa.email
    labels = {
      env = "prod"
    }
    tags = ["gke-node"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}


