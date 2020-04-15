. ./env.sh

build() {
    local attr=${1:?attr}
    local config=${2:?config}
    nix-build '<nixpkgs/nixos>' -A "$attr" -I nixos-config="$config"
}

build 'config.system.build.image' ./minimal/configure.nix

