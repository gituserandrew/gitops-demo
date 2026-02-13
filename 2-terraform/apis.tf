resource "google_project_service" "enable_apis" {
  for_each = toset(local.apis)
  service  = each.value
  disable_on_destroy = false
}


