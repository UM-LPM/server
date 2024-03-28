{config, pkgs, ...}:

let
  src = pkgs.fetchFromGitHub {
    owner = "UM-LPM";
    repo = "bioma2022-release";
    rev = "15ff7032bb73ed2e4c46fc6bd310e2ba47d2cbbb";
    hash = "sha256-tXFf18qFmWJNpZHnQhI9pLhSQ72KDZyvF5w+i/j5Vj0=";
  };
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/bioma.nix
  ];

  networking.firewall.allowedTCPPorts = [22 8080 9100];

  services.nginx = {
    enable = true;
    virtualHosts = {
      "_" = {
        listen = [
          {addr="0.0.0.0"; port = 8080;}
        ];
        locations."/" = {
          root = src;
        };
      };
    };
  };
}
