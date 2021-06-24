provider "google" {
  project     = "qwiklabs-gcp-01-3cd8e2f13322"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
