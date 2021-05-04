provider "google" {
  credentials = "${file(var.key_path)}"
  region = "<region>"
  project = "<project id>"
}

resource "google_cloud_run_service" "default" {
  name     = "blog"
  location = "<region>"
  template {
    spec {
      containers {
        image = "gcr.io/<project id>/blog"
        ports{
          container_port = 1323
        }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

# Return service URL
output "url" {
  value = "${google_cloud_run_service.default.status[0].url}"
}
