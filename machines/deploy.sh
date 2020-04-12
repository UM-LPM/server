#! /usr/bin/env nix-shell
#! nix-shell -i bash -p "(nixos {}).nixos-rebuild"

deploy() {
    local host=$1
    local config=$2
    NIX_SSHOPTS='-F ./ssh_config' nixos-rebuild switch --target-host "$host" -I nixos-config="$config" -I nixpkgs='https://github.com/nixos/nixpkgs/archive/29eddfc36d720dcc4822581175217543b387b1e8.tar.gz'
}

deploy bastion './bastion/configure.nix'
#deploy gateway './gateway/configure.nix'
deploy spum-platform './spum-platform/configure.nix'
deploy spum-mqtt './spum-mqtt/configure.nix'
deploy spum-docker-registry './spum-docker-registry/configure.nix'
