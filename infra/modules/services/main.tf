resource "libvirt_pool" "pool" {
  name = "services_pool"
  type = "dir"
  path = "/var/lib/pools/services"
}

resource "libvirt_volume" "bastion" {
  name = "bastion"
  pool = libvirt_pool.pool.name
  base_volume_id = var.base_image_id["bastion"]
  format = "qcow2"
}

resource "libvirt_volume" "gateway" {
  name = "gateway"
  pool = libvirt_pool.pool.name
  base_volume_id = var.base_image_id["gateway"]
  format = "qcow2"
}

resource "libvirt_domain" "bastion" {
  name = "bastion"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.private_network_id
    addresses = [var.hosts["bastion"]]
  }

  network_interface {
    macvtap = var.public_network_interface
  }

  disk {
    volume_id = libvirt_volume.bastion.id
  }
}

resource "libvirt_domain" "gateway" {
  name = "gateway"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.private_network_id
    addresses = [var.hosts["gateway"]]
  }

  network_interface {
    macvtap = var.public_network_interface
  }

  disk {
    volume_id = libvirt_volume.gateway.id
  }
}
