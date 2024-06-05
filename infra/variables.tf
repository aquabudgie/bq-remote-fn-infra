variable "project" {
  type        = string
  default     = ""
  description = "description"
}

variable "region" {
  type        = string
  default     = "australia-southeast1"
  description = "description"
}

variable "function_source" {
  type    = string
  default = "../function_source"
}

variable "bucket_object_name" {
  type        = string
  description = "name of cloud functions source bucket object"
  default     = "cloud_function_source"
}

variable "service_config" {
  type = object({
    all_traffic_on_latest_revision   = bool
    available_cpu                    = string
    available_memory                 = string
    max_instance_count               = number
    max_instance_request_concurrency = number
    min_instance_count               = number
    timeout_seconds                  = number
    ingress_settings                 = string
  })
  default = {
    all_traffic_on_latest_revision   = true
    available_cpu                    = 0.333
    available_memory                 = "512M"
    max_instance_count               = 100
    max_instance_request_concurrency = 1
    min_instance_count               = 0
    timeout_seconds                  = 60
    ingress_settings                 = "ALLOW_INTERNAL_ONLY"
  }
  description = "cloud function service config"
}