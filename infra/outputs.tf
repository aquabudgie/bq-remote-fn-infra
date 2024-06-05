output "bq_connection_service_account" {
  value = "serviceAccount:${google_bigquery_connection.parse_useragents.cloud_resource.0.service_account_id}"
}
