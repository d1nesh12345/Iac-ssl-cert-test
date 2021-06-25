provider "google" {
  project     =  "qwiklabs-gcp-02-26a435304b1c"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
