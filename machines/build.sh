#machines=(
#    ./bastion/
#    ./gateway/
#    ./minimal/
#)
machines=("$@")

for machine in "${machines[@]}"
do
    pushd "$machine"
    nix-build '<nixpkgs/nixos>' -A config.system.build.image -I nixos-config=configure.nix &
    popd
done

wait $(jobs -p)
