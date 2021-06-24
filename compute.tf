

resource "google_compute_instance" "default" {
  name         = "test1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo1", "bar1"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
 // scratch_disk {
  //  interface = "SCSI"
 // }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar1"
  }

  metadata_startup_script = "echo hi > /test.txt"

}

resource "google_compute_instance" "default" {
  name         = "test2"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo2", "bar2"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
 // scratch_disk {
  //  interface = "SCSI"
 // }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar2"
  }

  metadata_startup_script = "echo hi > /test.txt"

}
