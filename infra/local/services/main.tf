provider "libvirt" {
  uri = "qemu:///system"
}

data "terraform_remote_state" "global" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
}

module "services" {
  source = "../../modules/services"
  global = data.terraform_remote_state.global.outputs.global
  public_network_interface = "enp0s31f6"
}
