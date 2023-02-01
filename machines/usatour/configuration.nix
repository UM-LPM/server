{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 9100];
}
