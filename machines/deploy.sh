#! /usr/bin/env nix-shell
#! nix-shell -i bash -p "(nixos {}).nixos-rebuild"

deploy() {
    local host=$1
    local config=$2
    NIX_SSHOPTS='-F ./ssh_config' nixos-rebuild switch --target-host "$host"  -I nixos-config="$config"
}

deploy bastion './bastion/configure.nix'
#deploy ssh://gateway './gateway/configure.nix'
#deploy ssh://spum_platform './spum-platform/configure.nix'
#deploy ssh://spum_mqtt './spum-mqtt/configure.nix'
#deploy ssh://spum_docker_registry './spum-docker-registry/configure.nix'
