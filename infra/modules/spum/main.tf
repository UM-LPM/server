resource "libvirt_pool" "pool" {
  name = "spum_pool"
  type = "dir"
  path = "/var/lib/pools/spum"
}

resource "libvirt_volume" "docker_registry" {
  name = "docker_registry"
  pool = libvirt_pool.pool.name
  base_volume_id = var.global.base_image_id.minimal
  format = "qcow2"
}

resource "libvirt_volume" "platform" {
  name = "platform"
  pool = libvirt_pool.pool.name
  base_volume_id = var.global.base_image_id.spum_platform
  format = "qcow2"
}

resource "libvirt_volume" "mqtt" {
  name = "mqtt"
  pool = libvirt_pool.pool.name
  base_volume_id = var.global.base_image_id.minimal
  format = "qcow2"
}

resource "libvirt_domain" "docker_registry" {
  name = "spum_docker_registry"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.global.private_network_id
    mac = "02:20:a9:41:f5:22"
    addresses = ["10.17.3.110"]
    hostname = "spum-docker-registry"
  }

  disk {
    volume_id = libvirt_volume.docker_registry.id
  }
}

resource "libvirt_domain" "platform" {
  name = "spum_platform"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.global.private_network_id
    mac = "02:a2:cd:0c:46:78"
    addresses = ["10.17.3.111"]
    hostname = "spum-platform"
  }

  disk {
    volume_id = libvirt_volume.platform.id
  }
}

resource "libvirt_domain" "mqtt" {
  name = "spum_mqtt"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.global.private_network_id
    mac = "02:38:60:94:88:cc"
    addresses = ["10.17.3.112"]
    hostname = "spum-mqtt"
  }

  disk {
    volume_id = libvirt_volume.mqtt.id
  }
}
