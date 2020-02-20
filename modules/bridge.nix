{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.networking.bridge;
in
{
  options.networking.bridge = {
    interface = mkOption {
      description = "Interface";
      type = types.str;
    };

    address = mkOption {
      description = "Bridge address";
      type = with types; submodule {
        options = {
          address = mkOption {
            description = "Address of the interface";
            type = types.str;
          };

          prefixLength = mkOption {
            description = "Subnet mask of the interface";
            type = types.int;
          };
        };
      };
    };

    defaultGateway = mkOption {
      description = "Bridge default gateway";
      type = with types; submodule {
        options = {
          address = mkOption {
            description = "Address of the default gateway";
            type = types.str;
          };
        };
      };
    };
  };

  config = {
    networking = {
      interfaces.${cfg.interface} = {

        # There is no DHCP on the network
        useDHCP = false;
        ipv4.addresses = [
          {
            address = cfg.address.address;
            prefixLength = cfg.address.prefixLength;
          }
        ];
      };
      defaultGateway = {
        address = cfg.defaultGateway.address;
        interface = cfg.interface;
        metric = 0; # The bridge must be used as a defualt gateway otherwise the machine cannot be reached
      };
    };
  };
}
