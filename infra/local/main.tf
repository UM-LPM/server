provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "network" {
  name = "network"
  mode = "nat"
  addresses = ["10.17.3.0/24"]
  dhcp {
    enabled = true
  }
}
