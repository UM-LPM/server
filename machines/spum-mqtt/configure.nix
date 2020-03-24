{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/docker-host.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/spum.nix
  ];

  networking.firewall.allowedTCPPorts = [22];

  networking.hostName = "spum-mqtt";
}
