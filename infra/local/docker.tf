resource "libvirt_domain" "docker" {
  name = "docker"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_name = libvirt_network.network.name
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  disk {
    volume_id = libvirt_volume.docker_host_image.id
  }
}
