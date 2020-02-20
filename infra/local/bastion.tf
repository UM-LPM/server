resource "libvirt_domain" "bastion" {
  name = "bastion"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = libvirt_network.local_network.id
    hostname = "bastion"
  }

  network_interface {
    macvtap = "enp0s31f6"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  disk {
    volume_id = libvirt_volume.bastion_image.id
  }
}

