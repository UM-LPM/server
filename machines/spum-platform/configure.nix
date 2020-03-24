{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/docker-host.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/spum.nix
  ];
  
  environment.systemPackages = [pkgs.docker-compose];

  networking.firewall.allowedTCPPorts = [22 80 5000];
}
