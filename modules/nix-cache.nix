{ pkgs, ... }:

{
  nix.settings = {
    substituters = [
      "http://builder.l"
    ];
    trusted-public-keys = [
      "cache.lpm.feri.um.si:TwiF0KOXmbNihiysjGaH7EZOMHUvuwy+1mI/EHGc56M="
    ];
  };
}
