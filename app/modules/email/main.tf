terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

# Cria um endereço de destino para o catch-all
resource "cloudflare_email_routing_address" "catch_all" {
  account_id 	= var.cloudflare_account_id
  email     	= var.cloudflare_forward_mail
}

# Cria uma regra de roteamento catch-all
resource "cloudflare_email_routing_catch_all" "catch_all" {
  zone_id = var.cloudflare_zone_id
  name    = "all"
  enabled = true
    
  matcher {
    type = "all"
  }

  action {
    type  = "forward"
    value = [var.cloudflare_forward_mail]
  }
}