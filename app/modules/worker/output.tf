output "cloudflare_worker_script_name" {
  description = "cloudflare_worker_script name"
  value = cloudflare_worker_script.aalc.name
  sensitive   = true
}