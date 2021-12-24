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
    ../../users/bioma.nix
    ../../users/mihaelhpc.nix
    ../../users/prometheus.nix
    ../../users/gb.nix
    ../../users/ears.nix
  ];

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

  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [9100];
}
