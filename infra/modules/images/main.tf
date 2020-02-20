locals {
  machines_path = var.machines_path
}

resource "libvirt_pool" "image_pool" {
  name = "image_pool"
  type = "dir"
  path = var.pool_path
}

resource "libvirt_volume" "minimal_image" {
  name = "minimal"
  pool = libvirt_pool.image_pool.name
  source = "${local.machines_path}/minimal/result/nixos.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "docker_host_image" {
  name = "docker_host"
  pool = libvirt_pool.image_pool.name
  source = "${local.machines_path}/docker-host/result/nixos.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "docker_registry_image" {
  name = "docker_registry"
  pool = libvirt_pool.image_pool.name
  source = "${local.machines_path}/docker-registry/result/nixos.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "bastion_image" {
  name = "bastion"
  pool = libvirt_pool.image_pool.name
  source = "${local.machines_path}/bastion/result/nixos.qcow2"
  format = "qcow2"
}
