{config, pkgs, ...}:

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
    "nodejs-16.20.1"
  ];
  nix.settings = {
    substituters = [
      "http://builder.l"
    ];
    trusted-public-keys = [
      "cache.lpm.feri.um.si:mRrqApyiZICyeWfyiEoJPy+Cz50YAJhN9Gpe49Bhmos="
    ];
  };


  security.polkit.enable = true;
  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;

  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [9100];

  age.secrets."collab-runner-token".file = ../../secrets/collab-runner-token.age;

  services.github-runners =
  let
    mkRunner = name: {
      inherit name;
      enable = true;
      user = "runner";
      tokenFile = config.age.secrets.collab-runner-token.path;
      url = "https://github.com/UM-LPM/QA";
    };
  in {
    collab1 = mkRunner "collab1";
    collab2 = mkRunner "collab2";
    collab3 = mkRunner "collab3";
    collab4 = mkRunner "collab4";
  };
}
