provider "libvirt" {
    uri = "qemu:///system"
}

resource "libvirt_pool" "pool" {
    name = "pool"
    type = "dir"
    path = "/tmp/local-pool/"
}

resource "libvirt_volume" "image" {
    name = "nixos"
    pool = libvirt_pool.pool.name
    source = "${path.module}/result/nixos.qcow2"
    format = "qcow2"
}

resource "libvirt_network" "network" {
    name = "network"
    mode = "nat"
    addresses = ["10.17.3.0/24"]
    dhcp {
        enabled = true
    }
}

resource "libvirt_domain" "domain" {
    name = "local"
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
        volume_id = libvirt_volume.image.id
    }
    
    graphics {
        type = "spice"
        listen_type = "address"
        autoport = true
    }
}

