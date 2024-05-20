terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "docker" {
  name = "docker:latest"
}

resource "docker_container" "deployer" {
  image = docker_image.docker.latest
  name  = "deployer"

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  volumes {
    host_path      = "/app/modules/tunnel_deploy/tunnel.yaml"
    container_path = "/tunnel.yaml"
  }

  entrypoint = ["sh", "-c", "while true; do sleep 3600; done"]
}

resource "null_resource" "docker_deploy" {
  provisioner "local-exec" {
    command = "export $(cat .env) > /dev/null 2>&1; docker exec ${docker_container.deployer.name} docker stack deploy -c /tunnel.yaml tunnel"
  }

  depends_on = [docker_container.deployer]
}