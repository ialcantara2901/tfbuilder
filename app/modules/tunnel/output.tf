#output "tunnel_token" {
#  description = "Cloudflare Tunnel Token"
#  value = cloudflare_tunnel.auto_tunnel.tunnel_token
#  sensitive   = true
#}

output "cloudflare_tunnel_cname" {
  description = "cloudflare_tunnel cname"
  value = cloudflare_tunnel.auto_tunnel.cname
}

output "cloudflare_tunnel_id" {
  description = "cloudflare_tunnel cname"
  value = cloudflare_tunnel.auto_tunnel.id
}
