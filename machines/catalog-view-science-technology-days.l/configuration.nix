{config, pkgs, lib, ...}:

let
  catalogId = "430bbc71-f251-475a-8759-7665a8b7b119";
  courses = (lib.importJSON ../../courses.json).${catalogId};
  catalog = (lib.importJSON ../../catalogs.json).${catalogId};
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
