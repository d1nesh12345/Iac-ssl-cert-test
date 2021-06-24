provider "google" {
  project     = "qwiklabs-gcp-04-75739a41967a"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
