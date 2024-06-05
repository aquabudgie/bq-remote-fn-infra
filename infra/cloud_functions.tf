
resource "google_cloudfunctions2_function" "parse_user_agents" {
  description = null
  labels = {
    deployment-tool = "cli-gcloud"
    owner           = local.common_tags.owner
    purpose         = local.common_tags.purpose
  }
  location = var.region
  name     = "ua_parser"
  project  = var.project
  build_config {
    docker_repository     = null
    entry_point           = "main"
    environment_variables = {}
    runtime               = "python39"
    worker_pool           = null
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.object.name
      }
    }
  }
  service_config {
    all_traffic_on_latest_revision   = var.service_config.all_traffic_on_latest_revision
    available_cpu                    = var.service_config.available_cpu
    available_memory                 = var.service_config.available_memory
    ingress_settings                 = var.service_config.ingress_settings
    max_instance_count               = var.service_config.max_instance_count
    max_instance_request_concurrency = var.service_config.max_instance_request_concurrency
    min_instance_count               = var.service_config.min_instance_count
    timeout_seconds                  = var.service_config.timeout_seconds
  }
  timeouts {
    create = null
    delete = null
    update = null
  }
}
