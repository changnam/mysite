provider "google" {
  credentials = "${file("account.json")}"
  project     = "qwiklabs-gcp-1d2eb7ebd1421882"
  region      = "us-central1"
  zone        = "us-central1-c"
}

provider "google-beta" {
  credentials = "${file("account.json")}"
  project     = "my-project-id"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_compute_instance" "default" {
  provider = "google"
  name         = "terraform"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
