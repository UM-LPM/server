machines=(
    ./bastion/
    ./gateway/
    ./minimal/
)

for machine in "${machines[@]}"
do
    pushd "$machine"
    nix-build '<nixpkgs/nixos>' -A config.system.build.image -I nixos-config=configure.nix &
    popd
done

wait $(jobs -p)
