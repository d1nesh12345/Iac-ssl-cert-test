provider "google" {
  project     =  "qwiklabs-gcp-02-a36f28477674"
  credentials = "${file("/tmp/key.json")}"
  region      = "us-central1"
  zone        = "us-central1-c"
  //services = [ "iam.googleapis.com", "container.googleapis.com", "monitoring.googleapis.com", "cloudtrace.googleapis.com", "clouddebugger.googleapis.com", "cloudprofiler.googleapis.com"]
}
