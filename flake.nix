{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-24.11;
    agenix.url = github:ryantm/agenix;
    sso-test.url = github:UM-LPM/sso-test;
    grades.url = github:UM-LPM/grades;
    collab.url = github:UM-LPM/QA/production;
    collab-dev.url = github:UM-LPM/QA;
    collab-test.url = github:UM-LPM/QA/test;
    login.url = github:UM-LPM/login/production;
    login-dev.url = github:UM-LPM/login;
    catalog.url = github:UM-LPM/short-courses-catalog/production;
    catalog-dev.url = github:UM-LPM/short-courses-catalog;
    catalog-manage.url = github:UM-LPM/short-courses-catalog/cms_implementation;
    gc.url = github:Mir1001/gc_mv_backend;
    feriusa.url = github:cecepasinechka/USA;
    ears.url = github:UM-LPM/tournaments;
  };

  outputs = {self, nixpkgs, agenix, sso-test, collab, collab-dev, collab-test, grades, login, login-dev, catalog, catalog-dev, catalog-manage, gc, feriusa, ears, ...}@inputs:
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "nodejs-16.20.2"
      ];
    };
    lib = pkgs.lib;
    sso-test-overlay = self: super: {
      service = sso-test.packages.x86_64-linux.service;
    };

    mkCourses = pkgs.callPackage ./packages/make-courses.nix {};

    updateCourses = catalog:
      pkgs.writeShellApplication {
        name = "update";

        runtimeInputs = [ pkgs.nix-prefetch pkgs.jq pkgs.moreutils ];

        text = ''
          set -euo pipefail

          # from https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/security/vault/update-bin.sh
          replace_sha() {
            jq ".\"${catalog}\".hash = \"$1\"" <courses.json | sponge courses.json
          }
          prefetch() {
            nix-prefetch -I 'nixpkgs=${nixpkgs}' --option extra-experimental-features flakes "$@"
          }

          hash=$(prefetch '
            { sha256 }:
            let flake = builtins.getFlake (toString ${./.}); in
            flake.packages.x86_64-linux.courses."${catalog}".overrideAttrs (_: { hash = sha256; })
          ')
          replace_sha "$hash"
        '';
      };

    updateSummerSchoolsView =
      pkgs.writeShellApplication {
        name = "update";

        runtimeInputs = [ pkgs.nix-prefetch pkgs.gnused ];

        text = ''
          set -euo pipefail

          # from https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/security/vault/update-bin.sh
          replace_sha() {
            sed -i "s#$1 = \"sha256-.\{44\}\"#$1 = \"$2\"#" "$3"
          }
          prefetch() {
            nix-prefetch -I 'nixpkgs=${nixpkgs}' --option extra-experimental-features flakes "$@"
          }

          hash=$(prefetch '
            { sha256 }:
            let flake = builtins.getFlake (toString ${./.}); in
            flake.packages.x86_64-linux.summerSchoolsView.src.overrideAttrs (_: { hash = sha256; })
          ')
          replace_sha hash "$hash" ./machines/catalog-summer-schools.l/view.nix
        '';
      };
  in
  {
    packages.x86_64-linux.mongo_exporter = pkgs.callPackage ./pkgs/mongo_exporter.nix {};

    packages.x86_64-linux.courses = builtins.mapAttrs (catalog: {revision, hash}:
        mkCourses {inherit catalog revision hash;})
      (lib.importJSON ./courses.json);

    packages.x86_64-linux.updateCourses = builtins.mapAttrs (catalog: _:
        updateCourses catalog)
      (lib.importJSON ./courses.json);

    packages.x86_64-linux.summerSchoolsView =
    let
      catalog = "277b8f71-87e7-45ab-92bf-027fcee1d392";
      lock = (lib.importJSON ./courses.json).${catalog};
    in
    pkgs.callPackage ./machines/catalog-summer-schools.l/view.nix {} {
      inherit catalog;
      inherit (lock) revision hash;
    };

    packages.x86_64-linux.updateSummerSchoolsView = updateSummerSchoolsView;

    nixosConfigurations =
    let
      mkSystem = hostname: extraModules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = extraModules ++ [
          agenix.nixosModules.default
          ./machines/${hostname}/configuration.nix
        ];
        specialArgs = {inherit inputs;};
      };
    in {
      "minimal.l" = mkSystem "minimal.l" [];
      "bastion.l" = mkSystem "bastion.l" [];
      "gateway.l" = mkSystem "gateway.l" [];
      "builder.l" = mkSystem "builder.l" [];
      "proxy.l" = mkSystem "proxy.l" [];
      "ps.l" = mkSystem "ps.l" [];
      "runner1.l" = mkSystem "runner1.l" [];
      "ears.l" = mkSystem "ears.l" [
        #ears.nixosModules.default
      ];
      "prometheus.l" = mkSystem "prometheus.l" [];
      "student-mqtt.l" = mkSystem "student-mqtt.l" [];
      "kaze.l" = mkSystem "kaze.l" [];
      "bioma.l" = mkSystem "bioma.l" [];
      "feriusa.l" = mkSystem "feriusa.l" [
        feriusa.nixosModules.wordpress
      ];
      "usatour.l" = mkSystem "usatour.l" [
        feriusa.nixosModules.wordpress
      ];
      "sso-test.l" = mkSystem "sso-test.l" [
        {nixpkgs.overlays = [sso-test-overlay];}
        sso-test.nixosModules.service
      ];
      "collab.l" = mkSystem "collab.l" [
        collab.nixosModules.default
      ];
      "collab-dev.l" = mkSystem "collab-dev.l" [
        {nixpkgs.overlays = [collab-dev.overlays.default];}
        collab-dev.nixosModules.default
      ];
      "collab-test.l" = mkSystem "collab-test.l" [
        {nixpkgs.overlays = [collab-test.overlays.default];}
        collab-test.nixosModules.default
      ];
      "collab-pora.l" = mkSystem "collab-pora.l" [
        {nixpkgs.overlays = [collab-dev.overlays.default];}
        collab-dev.nixosModules.default
      ];
      "collab-rri.l" = mkSystem "collab-rri.l" [
        {nixpkgs.overlays = [collab-dev.overlays.default];}
        collab-dev.nixosModules.default
      ];
      "collab-vr.l" = mkSystem "collab-vr.l" [
        {nixpkgs.overlays = [collab-dev.overlays.default];}
        collab-dev.nixosModules.default
      ];
      "collab-catalog-dev.l" = mkSystem "collab-catalog-dev.l" [
        {nixpkgs.overlays = [collab-dev.overlays.default];}
        collab-dev.nixosModules.default
      ];
      "login.l" = mkSystem "login.l" [
        login.nixosModules.default
      ];
      "login-dev.l" = mkSystem "login-dev.l" [
        login-dev.nixosModules.default
      ];
      "catalog.l" = mkSystem "catalog.l" [
        catalog.nixosModules.default
      ];
      "catalog-dev.l" = mkSystem "catalog-dev.l" [
        catalog-dev.nixosModules.default
      ];
      "catalog-view.l" = mkSystem "catalog-view.l" [
        catalog-manage.nixosModules.default
      ];
      "catalog-summer-schools.l" = mkSystem "catalog-summer-schools.l" [
        catalog-manage.nixosModules.default
      ];
      "catalog-manage.l" = mkSystem "catalog-manage.l" [
        catalog-manage.nixosModules.default
      ];
      "grades.l" = mkSystem "grades.l" [
        grades.nixosModules.default
      ];
      "gc.l" = mkSystem "gc.l" [
        gc.nixosModules.default
      ];
      "gc-dev.l" = mkSystem "gc-dev.l" [
        gc.nixosModules.default
      ];
      "lpm.rwx.si" = mkSystem "aws" [
        collab-test.nixosModules.default
        login-dev.nixosModules.default
      ];
    };

    packages."x86_64-linux" = {
      "known-hosts" = pkgs.callPackage ./ssh/known-hosts.nix {};
    };
  };
}
