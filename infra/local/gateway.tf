resource "libvirt_domain" "gateway" {
  name = "gateway"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = libvirt_network.local_network.id
    hostname = "gateway"
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
    volume_id = libvirt_volume.gateway_image.id
  }
}

