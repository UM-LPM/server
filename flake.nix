{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.11;
    agenix.url = github:ryantm/agenix;
    sso-test.url = github:UM-LPM/sso-test;
  };

  outputs = {self, nixpkgs, agenix, sso-test}@inputs:
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux; 

    sso-test-overlay = self: super: {
      service = sso-test.packages.x86_64-linux.service;
    };
  in
  {
    nixosConfigurations = 
    let
      mkSystem = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          agenix.nixosModules.default
          ./modules/secrets.nix
          ./machines/${hostname}/configuration.nix
          {nixpkgs.overlays = [sso-test-overlay];}
          sso-test.nixosModules.service
        ];
        specialArgs = {inherit inputs;};
      };
    in {
      "sso-test.l" = mkSystem "sso-test.l";
    };

    packages."x86_64-linux" = {
      "known-hosts" = pkgs.callPackage ./ssh/known-hosts.nix {};
    };
  };
}
