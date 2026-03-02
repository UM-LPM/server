{config, pkgs, lib, ...}:

let
  catalog = "cc62de00-01e9-49a3-9109-00208f504aec";
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
      enable = true;
      serverUrl = "https://upravljanje-katalog.lpm.feri.um.si/api";
      privacyPolicyUrl = "https://feri.um.si/o-nas/dokumentno-sredisce/zasebnost/";
      shortCoursesUrl = "https://strokovne-dejavnosti.feri.um.si";
      catalogId = catalog;
      requireDateOfBirth = false;
      timestamp = lock.revision;
    };

    coursePictures = {
      address = "https://upravljanje-katalog.lpm.feri.um.si/";
    };
  };
}
