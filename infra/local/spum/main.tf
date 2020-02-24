provider "libvirt" {
  uri = "qemu:///system"
}

data "terraform_remote_state" "core" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
}

module "spum" {
  source = "../../modules/spum"
  base_image_id = data.terraform_remote_state.core.outputs.base_image_id
  private_network_id = data.terraform_remote_state.core.outputs.private_network_id
  hosts = data.terraform_remote_state.core.outputs.hosts
}
