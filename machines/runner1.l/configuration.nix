{config, pkgs, pkgs-unstable, ...}:
let
  github-runner = pkgs-unstable.github-runner; #.override { nodeRuntimes = [ "node16" "node20" ]; };
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
      "cache.lpm.feri.um.si:mRrqApyiZICyeWfyiEoJPy+Cz50YAJhN9Gpe49Bhmos="
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

  services.github-runners =
  let
    mkCollabRunner = name: {
      inherit name;
      enable = true;
      package = github-runner;
      user = "runner";
      tokenFile = config.age.secrets.collab-runner-token.path;
      url = "https://github.com/UM-LPM/QA";
    };
    mkLoginRunner = name: {
      inherit name;
      enable = true;
      package = github-runner;
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
  };
}
