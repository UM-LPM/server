export LIBVIRT_DEFAULT_URI="qemu+ssh://user@lpm-server.feri.um.si:12022/system"

extract-name() {
    cut -d' ' -f 2
}

# Network
network-create() {
    local file=${1:?file}
    local name=$(virsh net-define "$file" | extract-name)
    virsh net-start "${name:?name}"
    virsh net-autostart "$name"
}

network-destroy() {
    local name=${1:?name}
    virsh net-destroy "$name"
    virsh net-undefine "$name"
}

network-recreate() {
    local name=${1:?name}
    local file=${2:?file}
    network-destroy "$name" &&
    network-create "$file"
}

network-list() {
    virsh net-list "$@"
}

network-leases() {
    local name=${1:?name}
    virsh net-dhcp-leases "$name"
}

# Domain
domain-create() {
    local file=${1:?file}
    xmllint --valid "$file" --noout
    local name=$(virsh define <(xsltproc "$file") | extract-name)
    virsh start "${name:?name}"
    virsh autostart "$name"
}

domain-destroy() {
    local name=${1:?name}
    virsh destroy "$name"
    virsh undefine "$name"
}

domain-shutdown() {
    local name=${1:?name}
    virsh shutdown "$name"
    while [[ $(virsh domstate "$name") == 'running' ]]
    do
        sleep 1
    done
}

domain-shutdown-all() {
    for name in $(virsh list --name)
    do
        domain-shutdown "$name"
    done
}

domain-start() {
    local name=${1:?name}
    virsh start "$name"
}

domain-start-all() {
    for name in $(virsh list --all --name)
    do
        domain-start "$name"
    done
}

domain-recreate() {
    local name=${1:?name}
    domain-destroy "$name" &&
    domain-create "$name"
}

domain-list() {
    virsh list "$@"
}

# Pool
pool-create() {
    local name=${1:?name}
    local path=${2:?path}
    virsh pool-define-as "$name" --type dir --target "$path"
    virsh pool-start "$name"
    virsh pool-autostart "$name"
}

pool-destroy() {
    local name=${1:?name}
    virsh pool-destroy "$name"
    virsh pool-undefine "$name"
}

pool-recreate() {
    local name=${1:?name}
    pool-destroy "$name" &&
    pool-create "$name"
}

pool-list() {
	virsh pool-list "$@"
}

# Volume
volume-create() {
    local pool=${1:?pool}
    local name=${2:?name}
    local size=${3:?size}
    virsh vol-create-as "$pool" "$name" "$size" --format qcow2
}

volume-create-backing() {
    local pool=${1:?pool}
    local name=${2:?name}
    local size=${3:?size}
    local base=${4:?base}
    virsh vol-create-as --pool "$pool" "$name" "$size" --allocation 0 --format qcow2 --backing-vol "$base" --backing-vol-format qcow2
}

volume-upload() {
    local pool=${1:?pool}
    local name=${2:?name}
    local file=${3:?file}
    virsh vol-upload --pool "$pool" "$name" "$file"
}

volume-destroy() {
    local pool=${1:?pool}
    local name=${2:?name}
	virsh vol-delete --pool "$pool" "$name"
}

volume-recreate() {
    local pool=${1:?pool}
    local name=${2:?name}
    volume-destroy "$pool" "$name" &&
    volume-create "$pool" "$name"
}

volume-list() {
    local pool=${1:?pool}
	virsh vol-list "$pool"
}
