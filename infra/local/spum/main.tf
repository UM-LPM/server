provider "libvirt" {
  uri = "qemu:///system"
}

data "terraform_remote_state" "global" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
}

module "spum" {
  source = "../../modules/spum"
  global = data.terraform_remote_state.global.outputs.global
}
