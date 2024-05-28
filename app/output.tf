output "cloudflare_tunnel_id" {
  description = "cloudflare tunnel ID"
  value = module.tunnel.cloudflare_tunnel_id
}

output "name_servers" {
  description = "A list of Cloudflare-assigned name servers. This is only populated for zones that use Cloudflare DNS."
  value       = try(cloudflare_zone.aalc[*].name_servers, null)
}