# Cloudflare variables
variable "cloudflare_sys" {
  description = "Domain root"
  type        = string
}

variable "cloudflare_forward_mail" {
  description = "E-Mail to forward"
  type        = string
}

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

#variable "cloudflare_zone_id" {
#  description = "Zone ID for your domain"
#  type        = string
#}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_email" {
  description = "Email address for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_token" {
  description = "Cloudflare API token created at https://dash.cloudflare.com/profile/api-tokens"
  type        = string
  sensitive   = true
}