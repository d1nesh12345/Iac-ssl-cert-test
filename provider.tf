provider "google" {
  project     = "qwiklabs-gcp-00-46d6754dc2eb"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
