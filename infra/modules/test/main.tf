resource "libvirt_pool" "pool" {
  name = "test_pool"
  type = "dir"
  path = "/var/lib/pools/test"
}

resource "libvirt_volume" "image" {
  name = "test_image"
  pool = libvirt_pool.pool.name
  base_volume_id = var.base_image_id["minimal"]
  format = "qcow2"
}

resource "libvirt_domain" "test" {
  name = "test"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.private_network_id
    hostname = "test"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  disk {
    volume_id = libvirt_volume.image.id
  }
}
