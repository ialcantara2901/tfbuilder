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

# Cloudflare variables
variable "cloudflare_tunnel_cname" {
  description = "cloudflare_tunnel_cname"
  type        = string
}

# Cloudflare variables
variable "cloudflare_tunnel_id" {
  description = "cloudflare_tunnel_id"
  type        = string
}
