resource "google_bigquery_dataset" "cloud-functions-dataset" {
  dataset_id    = "cf_routines"
  friendly_name = "Cloud functions routines"
  description   = "Dataset to contain cloud function routines"
  location      = var.region
}


resource "google_bigquery_connection" "parse_useragents" {
  connection_id = "uaparse-tf"
  description   = null
  friendly_name = null
  location      = var.region
  project       = var.project
  cloud_resource {}
}

resource "google_project_iam_member" "run_invoker_binding" {
  project = var.project
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_bigquery_connection.parse_useragents.cloud_resource.0.service_account_id}"
}

locals {
  generate_useragent_query = <<-EOT
    CREATE OR REPLACE FUNCTION `${var.project}`.${reverse(split("/", google_bigquery_dataset.cloud-functions-dataset.dataset_id))[0]}.parse_useragents_tf(useragent STRING) RETURNS JSON
    REMOTE WITH CONNECTION `${var.project}.${var.region}.${reverse(split("/", google_bigquery_connection.parse_useragents.id))[0]}`
    OPTIONS (endpoint = '${google_cloudfunctions2_function.parse_user_agents.service_config[0].uri}')
  EOT
}

resource "random_id" "bq_job_suffix" {
  byte_length = 3
  keepers = {
    generate_slides = sha256(local.generate_useragent_query)
  }
}

resource "google_bigquery_job" "cf-create-remote-function-job" {
  job_id = "cf-create-remote-function-job-${random_id.bq_job_suffix.hex}"

  query {
    # empty values required for DDL statements
    create_disposition = ""
    write_disposition  = ""
    query              = local.generate_useragent_query
  }
  location = var.region

}