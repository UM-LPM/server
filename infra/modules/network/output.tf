output "private_network_id" {
  value = libvirt_network.private_network.id
}

output "hosts" {
  value = var.hosts
}
