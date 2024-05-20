terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

resource "random_password" "tunnel_secret" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Creates a new locally-managed tunnel.
resource "cloudflare_tunnel" "auto_tunnel" {
  account_id = var.cloudflare_account_id
  name       = join("", [var.cloudflare_sys, "_tunnel"])
  secret     = base64sha256(random_password.tunnel_secret.result)
}

resource "terraform_data" "env" {
  provisioner "local-exec" {
    command = "echo tunnel_token=$tunnel_token1 >> .env"
    environment = {
      tunnel_token1 = cloudflare_tunnel.auto_tunnel.tunnel_token
    }
  }
}