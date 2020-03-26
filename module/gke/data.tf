# Fetches the project name, and provides the appropriate URLs to use for container registry.
data "google_container_registry_repository" "kubernetes" {
  # The GCR region to use.
  region = "asia"
}