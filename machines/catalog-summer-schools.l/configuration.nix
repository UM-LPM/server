{config, pkgs, ...}:

let
  catalog = "3b88bf36-eb8b-4c9f-bd29-545451665e87";
  view = pkgs.callPackage ./view.nix {} {inherit catalog;};
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
      shortCoursesUrl = "https://poletne-sole.feri.um.si";
      catalogId = catalog;
    };

    coursePictures = {
      address = "https://upravljanje-katalog.lpm.feri.um.si/images/";
    };
  };
}
