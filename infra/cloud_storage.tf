resource "google_storage_bucket" "bucket" {
  name     = "${var.project}-gcf-source"  # Every bucket name must be globally unique
  location = var.region
  uniform_bucket_level_access = true
#   tags=local.common_tags
}

resource "google_storage_bucket_object" "object" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.bucket.name
  source = "../cloud_function_emulation/function-source.zip"  # Add path to the zipped function source code
}
