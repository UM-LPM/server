{config, pkgs, pkgs-unstable, pkgs-23_11, ...}:
let
  github-runner = pkgs.github-runner; #.override { nodeRuntimes = [ "node16" "node20" ]; };
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/runner.nix
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;
  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.0"
  ];
  nix.settings = {
    substituters = [
      "http://builder.l"
    ];
    trusted-public-keys = [
      "cache.lpm.feri.um.si:TwiF0KOXmbNihiysjGaH7EZOMHUvuwy+1mI/EHGc56M="
    ];
  };

  security.polkit.enable = true;
  boot.tmp.cleanOnBoot = true;
  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;

  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [9100];

  age.secrets."collab-runner-token".file = ../../secrets/collab-runner-token.age;
  age.secrets."login-runner-token".file = ../../secrets/login-runner-token.age;
  age.secrets."catalog-runner-token".file = ../../secrets/catalog-runner-token.age;
  age.secrets."grades-runner-token".file = ../../secrets/grades-runner-token.age;

  services.github-runners =
  let
    laxRunner = {name, tokenFile, url}: {
      inherit name tokenFile url;
      enable = true;
      package = github-runner;
      extraPackages = [pkgs.curl];
      user = "runner";
      serviceOverrides = {
        RestrictNamespaces = false;
        SystemCallFilter = [
          "@clock"
          "@cpu-emulation"
          "@module"
          "@mount"
          "@obsolete"
          "@raw-io"
          "@reboot"
          "capset"
          "setdomainname"
          "sethostname"
        ];
      };
    };
    mkCollabRunner = name: laxRunner {
      inherit name;
      tokenFile = config.age.secrets.collab-runner-token.path;
      url = "https://github.com/UM-LPM/QA";
    };
    mkCatalogRunner = name: laxRunner {
      inherit name;
      tokenFile = config.age.secrets.catalog-runner-token.path;
      url = "https://github.com/UM-LPM/short-courses-catalog";
    };
    mkGradesRunner = name: laxRunner {
      inherit name;
      tokenFile = config.age.secrets.grades-runner-token.path;
      url = "https://github.com/UM-LPM/grades";
    };
    mkLoginRunner = name: {
      inherit name;
      enable = true;
      package = github-runner;
      extraPackages = [pkgs.curl];
      user = "runner";
      tokenFile = config.age.secrets.login-runner-token.path;
      url = "https://github.com/UM-LPM/login";
    };
  in {
    collab1 = mkCollabRunner "collab1";
    collab2 = mkCollabRunner "collab2";
    collab3 = mkCollabRunner "collab3";
    collab4 = mkCollabRunner "collab4";
    login1 = mkLoginRunner "login1";
    login2 = mkLoginRunner "login2";
    catalog1 = mkCatalogRunner "catalog1";
    catalog2 = mkCatalogRunner "catalog2";
    grades1 = mkGradesRunner "grades1";
    grades2 = mkGradesRunner "grades2";
  };
}
