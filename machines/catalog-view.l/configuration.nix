{config, pkgs, ...}:

let
  view = pkgs.callPackage ./view.nix {};
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
      serverUrl = "https://scms.catalog.lpm.rwx.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      shortCoursesUrl = "https://catalog.lpm.rwx.si";
      catalogId = "3b88bf36-eb8b-4c9f-bd29-545451665e87";
    };

    coursePictures = {
      address = "https://scms.catalog.lpm.rwx.si/images/";
    };
  };
}
