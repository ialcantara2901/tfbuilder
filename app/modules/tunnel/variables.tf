# Cloudflare variables
variable "cloudflare_sys" {
  description = "Domain root"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}