resource "google_compute_managed_ssl_certificate" "default" {
  name = "test-cert"

  managed {
    domains = ["sslcert.tf-test.club."]
  }
}

resource "google_compute_target_https_proxy" "default" {
  name             = "test-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.self_link]
}

resource "google_compute_url_map" "default" {
  name        = "url-map"
  description = "a description"

  default_service = google_compute_backend_service.default.self_link

  host_rule {
    hosts        = ["sslcert.tf-test.club"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.default.self_link

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.default.self_link
    }
  }
}

resource "google_compute_backend_service" "default" {
  name        = "backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = [google_compute_http_health_check.default.self_link]
}

resource "google_compute_http_health_check" "default" {
  provider           = google
  name        = "http-health-check"
  description = "Health check via http"
  timeout_sec         = 1
  check_interval_sec  = 1
  healthy_threshold   = 4
  unhealthy_threshold = 5

  http_health_check {
    port_specification = "USE_NAMED_PORT"
    request_path       = "/healthcheck"
    proxy_header       = "NONE"
    response           = "I_AM_HEALTHY"
  }
}

resource "google_dns_managed_zone" "zone" {
  name     = "dnszone"
  dns_name = "sslcert.tf-test.club."
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "forwarding-rule"
  target     = google_compute_target_https_proxy.default.self_link
  port_range = 443
}

resource "google_dns_record_set" "set" {
  name         = "sslcert.tf-test.club."
  type         = "A"
  ttl          = 3600
  managed_zone = google_dns_managed_zone.zone.name
  rrdatas      = [google_compute_global_forwarding_rule.default.ip_address]
}
