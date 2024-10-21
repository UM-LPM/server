{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/ears.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100];

  age.secrets."ears-runner-token".file = ../../secrets/ears-runner-token.age;

  services.github-runners =
    let
      mkRunner = name: {
        inherit name;
        enable = true;
        user = "ears";
        tokenFile = config.age.secrets.ears-runner-token.path;
        url = "https://github.com/UM-LPM/tournaments";
      };
    in
    {
      runner1 = mkRunner "runner1";
      runner2 = mkRunner "runner2";
      runner3 = mkRunner "runner3";
    }
  }
