{config, pkgs, lib, ...}:

let
  catalog = "277b8f71-87e7-45ab-92bf-027fcee1d392";
  lock = (lib.importJSON ../../courses.json).${catalog};

  view = pkgs.callPackage ./view.nix {} {
    inherit catalog;
    inherit (lock) revision hash;
  };
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/catalog.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 8001];

  services.nginx.enable = true;
  services.nginx.virtualHosts."$hostname" = {
    root = view;
  };

  noo.services.catalog = {
    enable = true;

    frontendSubscribe = {
      enable = true;
      serverUrl = "https://upravljanje-katalog.lpm.feri.um.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      shortCoursesUrl = "https://pocitniske-sole.feri.um.si";
      catalogId = catalog;
      requireDateOfBirth = true;
      timestamp = lock.revision;
    };

    coursePictures = {
      address = "https://upravljanje-katalog.lpm.feri.um.si/images/";
    };
  };
}
