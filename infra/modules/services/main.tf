resource "libvirt_pool" "pool" {
  name = "services_pool"
  type = "dir"
  path = "/var/lib/pools/services"
}

resource "libvirt_volume" "bastion" {
  name = "bastion"
  pool = libvirt_pool.pool
  base_volume_id = var.base_image_id["bastion"]
  format = "qcow2"
}

resource "libvirt_domain" "bastion" {
  name = "bastion"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.private_network_id
  }

  network_interface {
    macvtap = var.public_network_interface
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  disk {
    volume_id = libvirt_volume.bastion.id
  }
}

resource "libvirt_volume" "gateway" {
  name = "gateway"
  pool = libvirt_pool.pool
  base_volume_id = var.base_image_id["gateway"]
  format = "qcow2"
}

resource "libvirt_domain" "gateway" {
  name = "gateway"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.private_network_id
  }

  network_interface {
    macvtap = var.public_network_interface
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  disk {
    volume_id = libvirt_volume.gateway.id
  }
}
