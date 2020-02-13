{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/user.nix
  ];
}
