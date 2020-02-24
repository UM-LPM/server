locals {
  image_paths = {
    minimal: "${var.machines_path}/minimal/result/nixos.qcow2"
    bastion: "${var.machines_path}/bastion/result/nixos.qcow2"
    gateway: "${var.machines_path}/gateway/result/nixos.qcow2"
  }
}

resource "libvirt_pool" "pool" {
  name = "base_image_pool"
  type = "dir"
  path = "/var/lib/pools/base_images"
}

resource "libvirt_volume" "base_image" {
  for_each = local.image_paths
  name = "${each.key}-base"
  pool = libvirt_pool.pool.name
  source = each.value
  format = "qcow2"
}
