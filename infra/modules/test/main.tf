resource "libvirt_pool" "pool" {
  name = "test_pool"
  type = "dir"
  path = "/var/lib/pools/test"
}

resource "libvirt_volume" "image" {
  name = "test_image"
  pool = libvirt_pool.pool.name
  base_volume_id = var.global.base_image_id.minimal
  format = "qcow2"
}

resource "libvirt_domain" "test" {
  name = "test"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.global.private_network_id
    mac = "02:a2:cd:0c:46:78"
    addresses = ["10.17.3.10"]
    hostname = "test"
    
  }

  disk {
    volume_id = libvirt_volume.image.id
  }
}
