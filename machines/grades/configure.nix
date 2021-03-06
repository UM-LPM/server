{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-host.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/grades.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100];
}
