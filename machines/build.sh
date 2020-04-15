. ./env.sh

build() {
    local attr=${1:?attr}
    local path=${2:?path}
    pushd "$path"
    nix-build '<nixpkgs/nixos>' -A "$attr" -I nixos-config='configure.nix'
    popd
}

build 'config.system.build.image' ./minimal

