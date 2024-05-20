terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

resource "cloudflare_zone" "aalc" {
	account_id	= var.cloudflare_account_id
  zone		    = var.cloudflare_zone
}