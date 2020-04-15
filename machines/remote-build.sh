. ./env.sh

build() {
    local attr=${1:?attr}
    local path=${2:?path}
    pushd "$path"
    nix-build '<nixpkgs/nixos>' -A "$attr" -I nixos-config='configure.nix' --max-jobs 0 --builders-use-substitutes --builders 'ssh://builder - - - - kvm'
    popd
}

build 'config.system.build.image' ./minimal
build 'config.system.build.image' ./bastion
build 'config.system.build.virtualBoxOVA' ./workspace
