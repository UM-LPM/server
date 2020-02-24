provider "libvirt" {
  uri = "qemu+ssh://user@lpm-server.feri.um.si/system"
}

data "terraform_remote_state" "core" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
}

module "services" {
  source = "../../modules/services"
  base_image_id = data.terraform_remote_state.core.outputs.base_image_id
  private_network_id = data.terraform_remote_state.core.outputs.private_network_id
  public_network_interface = "eno1"
}
