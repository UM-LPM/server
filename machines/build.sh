. ./env.sh

build() {
    local attr=${1:?attr}
    local path=${2:?path}
    local pkgs=${3:-https://channels.nixos.org/23.05/nixexprs.tar.xz}
    pushd "$path"
    nix-build '<nixpkgs/nixos>' -A "$attr" -I nixpkgs="$pkgs" -I nixos-config='configuration.nix'
    popd
}

build 'config.system.build.image' ./minimal
#build 'config.system.build.image' ./bastion
#build 'config.system.build.isoImage' ./aeneas-workstation/

