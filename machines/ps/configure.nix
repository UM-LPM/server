{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/docker-host.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/ps.nix
  ];

  environment.systemPackages = [pkgs.docker-compose];

  networking.firewall.allowedTCPPorts = [22 5050];
}
