resource "google_container_cluster" "default" {
  name        = var.name
  description = "Demo GKE Cluster"
  location    = var.location

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

   spec {
    container {
      image = "nginx:1.7.9"
      name  = "example"

      port {
        container_port = 8080
      }
    }
  
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
    
    

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
  
  resource "kubernetes_service" "example" {
  metadata {
    name = "ingress-service"
  }
  spec {
    port {
      port = 80
      target_port = 80
      protocol = "TCP"
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress" "example" {
  wait_for_load_balancer = true
  metadata {
    name = "example"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service_name = kubernetes_service.example.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}
