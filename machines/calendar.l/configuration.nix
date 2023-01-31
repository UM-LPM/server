{config, pkgs, ...}:

let
  src = pkgs.fetchFromGitHub {
    owner = "brokenpylons";
    repo = "Calendar";
    rev = "edea86259ba452cba87b11cc2bbaf74fad47a630";
    sha256 = "0zi5b2zbi011b8p1y422kgsws63rfwdwp0k0wn4fa8184fikk35p";
  };
  calendar = (pkgs.callPackage src {}).package;

  pinpkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "7e9b0dff974c89e070da1ad85713ff3c20b0ca97";
    sha256 = "1ckzhh24mgz6jd1xhfgx0i9mijk6xjqxwsshnvq789xsavrmsc36";
  }) {};
  browser = pinpkgs.chromium;
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/calendar.nix
  ];

  networking.firewall.allowedTCPPorts = [22 8080 9100];
  fonts.fontconfig.enable = pkgs.lib.mkForce true; # Make overridable?
  environment.systemPackages = [browser calendar];

  systemd.services.calendar = {
    wantedBy = ["multi-user.target"]; 
    after = ["network.target"];
    description = "Start the calendar service";
    environment = {
      NODE_ENV = "production";
      PORT = "8080";
      HOST = "0.0.0.0";
      BROWSER_PATH = "${browser}/bin/chromium";
    };
    serviceConfig = {
      Type = "simple";
      User = "calendar";
      Restart = "always";
      ExecStart = "${calendar}/bin/calendar";
    };
  };
}
