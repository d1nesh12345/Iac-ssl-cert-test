provider "google" {
  project     =  "qwiklabs-gcp-01-edb242c50a38"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
