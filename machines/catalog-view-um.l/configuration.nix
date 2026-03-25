{config, pkgs, lib, ...}:

let
  catalogId = "221f1cc4-1607-4418-a6a5-4b3fb897d82c";
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

    extraConfig = ''
      default_type "text/html";
      rewrite ^/(.*)/$ /$1 permanent;
      error_page 404 /404.html;
      try_files $uri $uri.html $uri/index.html index.html =404;
    '';
  };

  noo.services.catalog = {
    enable = true;

    frontendSubscribe = {
      inherit catalogId;
      enable = true;
      serverUrl = "https://upravljanje-katalog.um.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      shortCoursesUrl = "https://krajsa-izobrazevanja.um.si";
      requireDateOfBirth = true;
      timestamp = courses.revision;
      coursePicturesAddress = "https://upravljanje-katalog.um.si/";
    };
  };
}
