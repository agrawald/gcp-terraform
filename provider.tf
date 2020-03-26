// Configure the Google Cloud provider
provider "google" {
  credentials = file("${var.credential_json}")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}
