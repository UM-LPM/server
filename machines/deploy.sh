#! /usr/bin/env nix-shell
#! nix-shell -i bash -p "(nixos {}).nixos-rebuild"

deploy() {
    local host=$1
    local config=$2
    NIX_SSHOPTS='-F ./ssh_config' nixos-rebuild switch --target-host "$host" -I nixos-config="$config" -I nixpkgs='https://github.com/nixos/nixpkgs/archive/708cb6b307b04ad862cc50de792e57e7a4a8bb5a.tar.gz'
}

#deploy bastion './bastion/configure.nix'
#deploy gateway './gateway/configure.nix'
#deploy spum-platform './spum-platform/configure.nix'
#deploy spum-mqtt './spum-mqtt/configure.nix'
#deploy spum-docker-registry './spum-docker-registry/configure.nix'
#deploy builder './builder/configure.nix'
