provider "libvirt" {
  uri = "qemu+ssh://user@lpm-server.feri.um.si:12022/system"
}

data "terraform_remote_state" "core" {
  backend = "local"
  
  config = {
    path = "../terraform.tfstate"
  }
}

module "test" {
  source = "../../modules/test"
  base_image_id = data.terraform_remote_state.core.outputs.base_image_id
  private_network_id = data.terraform_remote_state.core.outputs.private_network_id
  hosts = data.terraform_remote_state.core.outputs.hosts
}
