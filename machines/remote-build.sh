. ./env.sh

build() {
    local attr=${1:?attr}
    local config=${2:?config}
    nix-build '<nixpkgs/nixos>' -A "$attr" -I nixos-config="$config" --max-jobs 0 --builders-use-substitutes --builders 'ssh://builder - - - - kvm'
}

build 'config.system.build.image' ./bastion/configure.nix
#build 'config.system.build.virtualBoxOVA' ./workspace/configure.nix
