terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

module "images" {
  source = "../modules/images"
  machines_path = "../../machines"
}

module "network" {
  source = "../modules/network"
}

output "global" {
  value = {
    base_image_id = module.images.base_image_id
    private_network_id = module.network.private_network_id
  }
}
