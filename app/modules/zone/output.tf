output "cloudflare_zone_id" {
  description = "Cloudflare zone id"
  value = cloudflare_zone.aalc.id
  sensitive   = true
}

output "name_servers" {
  description = "A list of Cloudflare-assigned name servers. This is only populated for zones that use Cloudflare DNS."
  value       = try(cloudflare_zone.aalc[*].name_servers, null)
}