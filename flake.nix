{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;
    agenix.url = github:ryantm/agenix;
    sso-test.url = github:UM-LPM/sso-test;
    collab.url = github:UM-LPM/QA;
    collab-dev.url = github:UM-LPM/QA/development;
  };

  outputs = {self, nixpkgs, agenix, sso-test, collab, collab-dev, ...}@inputs:
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux; 

    sso-test-overlay = self: super: {
      service = sso-test.packages.x86_64-linux.service;
    };
  in
  {
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
      "bastion.l" = mkSystem "bastion.l" [];
      "gateway.l" = mkSystem "gateway.l" [];
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
