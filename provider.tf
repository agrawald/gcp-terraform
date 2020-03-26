// Configure the Google Cloud provider
provider "google" {
  credentials = file("terraform-a03cb9936d10.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}
