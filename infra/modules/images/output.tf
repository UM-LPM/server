output "image_pool_name" {
  value = libvirt_pool.image_pool.name
  description = "Image pool name"
}

output "minimal_image_id" {
  value = libvirt_volume.minimal_image.id
  description = "Minimal image id"
}

output "docker_host_image_id" {
  value = libvirt_volume.docker_host_image.id
  description = "Docker host image id"
}

output "docker_registry_image_id" {
  value = libvirt_volume.docker_registry_image.id
  description = "Docker registry image id"
}

output "bastion_image_id" {
  value = libvirt_volume.bastion_image.id
  description = "Bastion image id"
}

output "gateway_image_id" {
  value = libvirt_volume.gateway_image.id
  description = "Gateway image id"
}

