resource "libvirt_network" "private_network" {
  name = "private_network"
  mode = "nat"

  addresses = ["10.17.3.0/24"]

  dhcp {
    enabled = true
  }
  dns {
    enabled = true
    
    dynamic "hosts" {
      for_each = var.hosts
      content {
        hostname = hosts.key
        ip = hosts.value
      }
    }
  }
}
