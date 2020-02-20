{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/bridge.nix
    ../../users/root.nix
    ../../users/user.nix
  ];

  networking.bridge = {
    interface = "ens4";

    address = {
      address = "164.8.230.209";
      prefixLength = 24;
    };

    defaultGateway = {
      address = "164.8.230.1";
    };
  };
}
