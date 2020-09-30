variable "provider_url" {
  description = "Provider URL"
  type        = string
  default     = ""
}

variable "thumbprint_list" {
  description = "CA Thumbprint"
  default     = []
}

variable "client_id_list" {
  description = "A list of client IDs"
  default     = ["sts.amazonaws.com"]
}
