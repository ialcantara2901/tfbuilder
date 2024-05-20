terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

# Creates the CNAME record that routes http_app.${var.cloudflare_zone} to the tunnel.
resource "cloudflare_record" "http_app" {
  zone_id = var.cloudflare_zone_id
  name    = "kuma"
  value   = var.cloudflare_tunnel_cname
  type    = "CNAME"
  proxied = true
}

# Creates the configuration for the tunnel.
resource "cloudflare_tunnel_config" "auto_tunnel" {
  tunnel_id   = var.cloudflare_tunnel_id
  account_id  = var.cloudflare_account_id
  config {
   ingress_rule {
     hostname = cloudflare_record.http_app.hostname
     service  = "http://kuma:3001"
   }
   ingress_rule {
     service  = "http_status:404"
   }
  }
}