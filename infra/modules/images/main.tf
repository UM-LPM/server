locals {
  image_paths = {
    minimal: "${var.machines_path}/minimal/result/nixos.qcow2"
    bastion: "${var.machines_path}/bastion/result/nixos.qcow2"
    gateway: "${var.machines_path}/gateway/result/nixos.qcow2"
    spum_docker_registry: "${var.machines_path}/spum-docker-registry/result/nixos.qcow2"
    spum_platform: "${var.machines_path}/spum-platform/result/nixos.qcow2"
    spum_mqtt: "${var.machines_path}/spum-mqtt/result/nixos.qcow2"
  }
}

resource "libvirt_pool" "pool" {
  name = "base_image_pool"
  type = "dir"
  path = "/var/lib/pools/base_images"
}

data "null_data_source" "hashsum" {
  for_each = local.image_paths
  inputs = {
    sha1 = "${filesha1(each.value)}"
  } 
}

resource "libvirt_volume" "base_image" {
  for_each = local.image_paths
  name = "${data.null_data_source.hashsum[each.key].outputs.sha1}-${each.key}-base"
  pool = libvirt_pool.pool.name
  source = each.value
  format = "qcow2"
}
