resource "libvirt_pool" "pool" {
  name = "spum_pool"
  type = "dir"
  path = "/var/lib/pools/spum"
}

resource "libvirt_volume" "docker_registry" {
  name = "docker_registry"
  pool = libvirt_pool.pool.name
  base_volume_id = var.global.base_image_id.spum_docker_registry
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
  base_volume_id = var.global.base_image_id.spum_mqtt
  format = "qcow2"
}

resource "libvirt_domain" "docker_registry" {
  name = "spum_docker_registry"
  memory = "1024"
  vcpu = 1

  network_interface {
    network_id = var.global.private_network_id
    addresses = [var.global.hosts.spum_docker_registry]
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
    addresses = [var.global.hosts.spum_platform]
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
    addresses = [var.global.hosts.spum_mqtt]
  }

  disk {
    volume_id = libvirt_volume.mqtt.id
  }
}
