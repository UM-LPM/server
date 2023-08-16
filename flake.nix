{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    agenix.url = github:ryantm/agenix;
    sso-test.url = github:UM-LPM/sso-test;
    collab.url = github:UM-LPM/QA/production;
    collab-dev.url = github:UM-LPM/QA;
  };

  outputs = {self, nixpkgs, agenix, sso-test, collab, collab-dev, ...}@inputs:
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
        inherit pkgs;

        modules = extraModules ++ [
          agenix.nixosModules.default
          ./modules/secrets.nix
          ./machines/${hostname}/configuration.nix
        ];
        specialArgs = {inherit inputs;};
      };
    in {
      "minimal" = mkSystem "minimal.l" [];
      "bastion.l" = mkSystem "bastion.l" [];
      "gateway.l" = mkSystem "gateway.l" [];
      "builder.l" = mkSystem "builder.l" [];
      "runner1.l" = mkSystem "runner1.l" [];
      "prometheus.l" = mkSystem "prometheus.l" [];
      "student-mqtt.l" = mkSystem "student-mqtt.l" [];
      "kaze.l" = mkSystem "kaze.l" [];
      "sso-test.l" = mkSystem "sso-test.l" [
        {nixpkgs.overlays = [sso-test-overlay];}
        sso-test.nixosModules.service
      ];
      "collab.l" = mkSystem "collab.l" [
        collab.nixosModules.default
      ];
      "collab-dev.l" = mkSystem "collab-dev.l" [
        collab-dev.nixosModules.default
      ];
    };

    packages."x86_64-linux" = {
      "known-hosts" = pkgs.callPackage ./ssh/known-hosts.nix {};
    };
  };
}
