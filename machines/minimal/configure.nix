{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/user.nix
  ];

  networking.hostName = "minimal";
}
