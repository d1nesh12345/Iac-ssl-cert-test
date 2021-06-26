provider "google" {
  project     =  "qwiklabs-gcp-03-f739732002e4"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
