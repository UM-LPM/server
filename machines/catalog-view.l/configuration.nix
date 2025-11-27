{config, pkgs, lib, ...}:

let
  catalogId = "16a9b89c-ccea-4deb-a112-b91652057cfe";
  courses = (lib.importJSON ../../courses.json).${catalogId};
  catalog = (lib.importJSON ../../catalogs.json).${catalogId};

  view = pkgs.callPackage ./view.nix {} {
    inherit catalogId courses catalog;
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
      inherit catalogId;
      enable = true;
      serverUrl = "https://upravljanje-katalog.lpm.feri.um.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      shortCoursesUrl = "https://catalog.lpm.rwx.si";
      requireDateOfBirth = true;
      timestamp = courses.revision;
    };

    coursePictures = {
      address = "https://upravljanje-katalog.lpm.feri.um.si/course/";
    };
  };
}
