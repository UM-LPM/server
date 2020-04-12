resource "libvirt_pool" "pool" {
  name = "services_pool"
  type = "dir"
  path = "/var/lib/pools/services"
}

resource "libvirt_volume" "bastion" {
  name = "bastion"
  pool = libvirt_pool.pool.name
  base_volume_id = var.global.base_image_id.bastion
  format = "qcow2"
}

resource "libvirt_volume" "gateway" {
  name = "gateway"
  pool = libvirt_pool.pool.name
  base_volume_id = var.global.base_image_id.minimal
  format = "qcow2"
}

resource "libvirt_domain" "bastion" {
  name = "bastion"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.global.private_network_id
    mac = "02:fe:9e:a7:5b:30"
    addresses = ["10.17.3.100"]
    hostname = "bastion"
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
    network_id = var.global.private_network_id
    mac = "02:63:81:cd:d5:b8"
    addresses = ["10.17.3.101"]
    hostname = "gateway"
  }

  network_interface {
    macvtap = var.public_network_interface
  }

  disk {
    volume_id = libvirt_volume.gateway.id
  }
}
