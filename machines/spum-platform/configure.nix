{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/docker-host.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/spum.nix
  ];
  nixpkgs.config.permittedInsecurePackages = [ # XXX: Insecure!
    "openssl-1.0.2u"
  ];

  environment.systemPackages = [pkgs.docker-compose pkgs.mongodb];

  networking.firewall.allowedTCPPorts = [22 80 5000];
}
