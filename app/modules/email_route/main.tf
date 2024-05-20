terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

# Cria o registro CNAME para o E-Mail
resource "cloudflare_record" "worker" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "CNAME"
  value   = var.cloudflare_worker_url
}

# Cria o registro CNAME para o Worker
resource "cloudflare_record" "smtp" {
  zone_id = var.cloudflare_zone_id
  name    = "smtp"
  type    = "CNAME"
  value   = "mail.smtp2go.com"
}

# Atualiza os MX records na Zona DNS Cloudflare
resource "cloudflare_record" "mx1" {
  zone_id = var.cloudflare_zone_id
  name    = var.cloudflare_zone
  type    = "MX"
  value   = "route1.mx.cloudflare.net"
  priority = 2
  # Define o TTL
  ttl = 60
}

resource "cloudflare_record" "mx2" {
  zone_id = var.cloudflare_zone_id
  name    = var.cloudflare_zone
  type    = "MX"
  value   = "route2.mx.cloudflare.net"
  priority = 5
  # Define o TTL
  ttl = 60
}

resource "cloudflare_record" "mx3" {
  zone_id = var.cloudflare_zone_id
  name    = var.cloudflare_zone
  type    = "MX"
  value   = "route3.mx.cloudflare.net"
  priority = 10 
  # Define o TTL
  ttl = 90
}

resource "cloudflare_record" "spf1" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "TXT"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
}

# Cria o registro CNAME SMTP
resource "cloudflare_record" "smtp2go_return" {
  zone_id = var.cloudflare_zone_id
  name    = "em905270"
  type    = "CNAME"
  value   = "return.smtp2go.net"
}

resource "cloudflare_record" "smtp2go_dkim" {
  zone_id = var.cloudflare_zone_id
  name    = "s905270"
  type    = "CNAME"
  value   = "dkim.smtp2go.net"
}

resource "cloudflare_record" "smtp2go_track" {
  zone_id = var.cloudflare_zone_id
  name    = "link"
  type    = "CNAME"
  value   = "track.smtp2go.net"
}