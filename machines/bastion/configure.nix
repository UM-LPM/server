{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/bridge.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/spum.nix
    ../../users/ps.nix
    ../../users/esp.nix
    ../../users/bass.nix
  ];

  networking.firewall.allowedTCPPorts = [22];

  networking.bridge = {
    interface = "ens3";

    address = {
      address = "164.8.230.209";
      prefixLength = 24;
    };

    defaultGateway = {
      address = "164.8.230.1";
    };
  };
}
