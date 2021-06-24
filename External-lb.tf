resource "google_compute_forwarding_rule" "default" {
  provider              = google
  name                  = "website-forwarding-rule"
  region                = "us-central1"
  port_range            = 80
  backend_service       = google_compute_region_backend_service.backend.id
}
resource "google_compute_region_backend_service" "backend" {
  provider              = google
  name                  = "website-backend"
  region                = "us-central1"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_region_health_check.hc.id]
  backend {
    group = google_compute_instance_group.test_grp.id
  }
}
resource "google_compute_region_health_check" "hc" {
  provider           = google
  name        = "http-health-check"
  description = "Health check via http"
  region             = "us-central1"
  timeout_sec         = 1
  check_interval_sec  = 1
  healthy_threshold   = 4
  unhealthy_threshold = 5

  http_health_check {
    port_name          = "health-check-port"
    port_specification = "USE_NAMED_PORT"
    request_path       = "/healthcheck"
    proxy_header       = "NONE"
    response           = "I_AM_HEALTHY"

  tcp_health_check {
    port = "80"
  }
}


