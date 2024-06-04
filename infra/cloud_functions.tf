
resource "google_cloudfunctions2_function" "parse_user_agents" {
  description = null
  labels = {
    deployment-tool = "cli-gcloud"
  }
  location = var.region
  name     = "uaparse-tf"
  project  = var.project
  build_config {
    docker_repository     = null
    entry_point           = "main"
    environment_variables = {}
    runtime               = "python39"
    worker_pool           = null
    source {
      storage_source {
        bucket     = google_storage_bucket.bucket.name
        object     = google_storage_bucket_object.object.name
      }
    }
  }
  service_config {
    all_traffic_on_latest_revision   = true
    available_cpu                    = "1000m"
    available_memory                 = "1Gi"
    environment_variables            = {}
    ingress_settings                 = "ALLOW_ALL"
    max_instance_count               = 1000
    max_instance_request_concurrency = 1
    min_instance_count               = 0
    # service                          = "projects/asher-caley-sandbox/locations/australia-southeast1/services/uaparse-tf"
    # service_account_email            = "950516818175-compute@developer.gserviceaccount.com"
    timeout_seconds                  = 59
    vpc_connector                    = null
    vpc_connector_egress_settings    = null
  }
  timeouts {
    create = null
    delete = null
    update = null
  }
}
