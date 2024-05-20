variable "cloudflare_worker_rote" {
  description = "worker_rote"
  type        = string
}

variable "cloudflare_worker_url" {
  description = "worker_url"
  type        = string
}

# Cloudflare variables
variable "cloudflare_zone" {
  description = "Domain used to expose VM instance to the Internet"
  type        = string
}

# Cloudflare variables
variable "cloudflare_zone_id" {
  description = "Domain used to expose VM instance to the Internet"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}