{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-24.05;
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
    gc.url = github:Mir1001/gc_mv_backend;
    feriusa.url = github:cecepasinechka/USA;
    ears.url = github:UM-LPM/tournaments;
  };

  outputs = {self, nixpkgs, agenix, sso-test, collab, collab-dev, collab-test, grades, login, login-dev, catalog, catalog-dev, gc, feriusa, ears, ...}@inputs:
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.permittedInsecurePackages = [
        "nodejs-16.20.2"
      ];
    };
    sso-test-overlay = self: super: {
      service = sso-test.packages.x86_64-linux.service;
    };
  in
  {
    packages.x86_64-linux.mongo_exporter = pkgs.callPackage ./pkgs/mongo_exporter.nix {};
    nixosConfigurations =
    let
      mkSystem = hostname: extraModules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = extraModules ++ [
          agenix.nixosModules.default
          ./modules/secrets.nix
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
      "catalog-view.l" = mkSystem "catalog-view.l" [];
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
