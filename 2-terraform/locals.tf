locals {
  project_id = "<your_created_project>"
  region = "us-central1"
  apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com"
  ]
  public_subnet_cidr = "10.100.96.0/20"
  private_subnet_cidr = "10.200.192.0/20"
  secondary_pods_ip_range_cidr =  "10.10.0.0/20"
  secondary_services_ip_range_cidr = "10.20.0.0/20"
}


