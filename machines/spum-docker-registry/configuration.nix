{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/docker-registry.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/spum.nix
  ];

  networking.firewall.allowedTCPPorts = [22];
}
