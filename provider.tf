provider "google" {
  project     = "qwiklabs-gcp-04-eeb0254dc548"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
}
