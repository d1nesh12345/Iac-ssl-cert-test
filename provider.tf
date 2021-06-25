provider "google" {
  project     = "qwiklabs-gcp-02-0de9fc38fe4b"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
