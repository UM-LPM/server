{config, pkgs, lib, ...}:

let
  catalog = "8f2cfd82-c470-43d2-9dfb-7dc67c6d9f2e";
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
      shortCoursesUrl = "https://mini-akademija.feri.um.si";
      catalogId = catalog;
      requireDateOfBirth = true;
      timestamp = lock.revision;
    };

    coursePictures = {
      address = "https://upravljanje-katalog.lpm.feri.um.si/";
    };
  };
}
