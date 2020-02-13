locals {
  machines_path = "../../machines"
}

resource "libvirt_pool" "image_pool" {
  name = "image_pool"
  type = "dir"
  path = "/tmp/local_image_pool"
}

resource "libvirt_volume" "minimal_image" {
    name = "minimal"
    pool = libvirt_pool.image_pool.name
    source = "${local.machines_path}/minimal/result/nixos.qcow2"
    format = "qcow2"
}
