terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

#Cria Rotas para o Worker
resource "cloudflare_worker_route" "dominio" {
  zone_id     = var.cloudflare_zone_id
  pattern     = var.cloudflare_zone
  script_name = var.cloudflare_worker_script_name
}
resource "cloudflare_worker_route" "subdominio" {
  zone_id     = var.cloudflare_zone_id
  pattern     = var.cloudflare_worker_rote
  script_name = var.cloudflare_worker_script_name
}

# Cria o registro CNAME "www" para o Worker
resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "CNAME"
  value   = var.cloudflare_worker_url
}