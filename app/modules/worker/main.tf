terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

# Cria a página no Workers
resource "cloudflare_worker_script" "aalc" {
  account_id  = var.cloudflare_account_id
  name        = var.cloudflare_sys

  # Define o conteúdo da página
  content = <<EOF
addEventListener('fetch', event => {
  event.respondWith(new Response(`
	<!DOCTYPE html>
	<html lang="pt-br">
	<head>
	  <meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <title></title>
	</head>
	<body style="background-color: #073b4c; text-align: center;">
	  <img src="logo.png" alt="Logo" style="margin: 0 auto; display: block;">
	</body>
	</html>
	`, {
		headers: {
		  'Content-Type': 'text/html'
		}
	  }));
	});
  EOF
}