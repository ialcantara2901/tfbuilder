terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

provider "cloudflare" {
  api_token               = var.cloudflare_token
}

module "zone" {
  source                  = "./modules/zone"
  cloudflare_account_id   = var.cloudflare_account_id
  cloudflare_zone         = var.cloudflare_zone
}

module "tunnel" {
  source                  = "./modules/tunnel"
  cloudflare_account_id   = var.cloudflare_account_id
  cloudflare_sys          = var.cloudflare_sys
}
/*
module "tunnel_route" {
  source                  = "./modules/tunnel_route"
  cloudflare_account_id   = var.cloudflare_account_id
  cloudflare_tunnel_id    = module.tunnel.cloudflare_tunnel_id
  cloudflare_zone_id      = module.zone.cloudflare_zone_id
  cloudflare_tunnel_cname = module.tunnel.cloudflare_tunnel_cname
}


module "tunnel_deploy" {
  source                  = "./modules/tunnel_deploy"
}

module "worker" {
  source                  = "./modules/worker"
  cloudflare_sys          = var.cloudflare_sys
  cloudflare_account_id   = var.cloudflare_account_id
}

module "worker_route" {
  source                  = "./modules/worker_route"
  cloudflare_zone         = var.cloudflare_zone
  cloudflare_zone_id      = module.zone.cloudflare_zone_id
  cloudflare_worker_rote  = var.cloudflare_worker_rote
  cloudflare_worker_url   = var.cloudflare_worker_url
  cloudflare_worker_script_name = module.worker.cloudflare_worker_script_name
}

module "email" {
  source                  = "./modules/email"
  cloudflare_account_id   = var.cloudflare_account_id
  cloudflare_zone         = var.cloudflare_zone
  cloudflare_zone_id      = module.zone.cloudflare_zone_id
  cloudflare_forward_mail = var.cloudflare_forward_mail
}

module "email_record" {
  source                  = "./modules/email_route"
  cloudflare_account_id   = var.cloudflare_account_id
  cloudflare_zone         = var.cloudflare_zone
  cloudflare_zone_id      = module.zone.cloudflare_zone_id
  cloudflare_worker_rote  = var.cloudflare_worker_rote
  cloudflare_worker_url   = var.cloudflare_worker_url
}
*/