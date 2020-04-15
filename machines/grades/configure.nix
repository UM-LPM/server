{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/docker-host.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/grades.nix
  ];

  networking.firewall.allowedTCPPorts = [22];
}
