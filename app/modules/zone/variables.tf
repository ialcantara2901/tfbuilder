# Cloudflare variables
variable "cloudflare_zone" {
  description = "Domain used to expose VM instance to the Internet"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}