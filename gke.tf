resource "google_container_cluster" "default" {
  name        = var.name
  description = "Demo GKE Cluster"
  location    = var.location

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

}

resource "google_container_node_pool" "default" {
  name       = "${var.name}-node-pool"
  location   = var.location
  cluster    = google_container_cluster.default.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
    }
    
     spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"

      port {
        container_port = 8080
      }
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
