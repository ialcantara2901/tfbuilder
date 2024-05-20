variable "cloudflare_forward_mail" {
  description = "E-Mail to forward"
  type        = string
}

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

# Cloudflare variables
variable "cloudflare_zone_id" {
  description = "Domain used to expose VM instance to the Internet"
  type        = string
}