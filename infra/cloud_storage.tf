resource "google_storage_bucket" "bucket" {
  name                        = "${var.project}-remote-function-source" # Every bucket name must be globally unique
  location                    = var.region
  uniform_bucket_level_access = true
  labels                      = local.common_tags
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.function_source
  output_path = "./tmp/function.zip"
}


resource "google_storage_bucket_object" "object" {
  name   = "${var.bucket_object_name}-${data.archive_file.source.id}"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.source.output_path
}
