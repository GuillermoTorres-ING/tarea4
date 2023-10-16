terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}


# Configuración de proveedor
provider "digitalocean" {
  token = "dop_v1_e0999c45259cc85e062b9c72e8cd02a78a60efc4ac3ceea96ece3b118dd48178"
}

resource "digitalocean_droplet" "first-project" {
  name  = "first-project"
  region  = "sfo3"
  image  = "ubuntu-23-04-x64"
  size   = "s-1vcpu-1gb"
  user_data = <<-EOF
      #!/bin/bash
    # Instalar Docker
    apt-get update
    apt-get -y install docker.io

    # Instalar Docker Compose
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    # Configurar variables de entorno para la aplicación
    echo 'export DATABASE_HOST=localhost' >> /etc/environment
    echo 'export DATABASE_USER=postgres' >> /etc/environment
    echo 'export DATABASE_PASSWORD=admin' >> /etc/environment

    # Configuración adicional del servidor de aplicación, incluyendo SSL 
    
    EOF
}