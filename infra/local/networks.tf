resource "libvirt_network" "local_network" {
  name = "local_network"
  mode = "nat"
  addresses = ["10.17.3.0/24"]
  dhcp {
    enabled = true
  }
  dns {
    enabled = true
  }
}
