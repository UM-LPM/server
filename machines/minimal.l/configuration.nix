{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/root.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22];
}
