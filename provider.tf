provider "google" {
  project     = "qwiklabs-gcp-00-5aceec377a09"
  credentials = "${file("/root/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
