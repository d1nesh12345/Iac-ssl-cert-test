provider "google" {
  project     = "qwiklabs-gcp-02-2a5a5a914a09"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
