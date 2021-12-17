{config, pkgs, ...}:

let
  src = pkgs.fetchFromGitHub {
    owner = "brokenpylons";
    repo = "Calendar";
    rev = "0fc790f436aa910608a1f74a3ed88b4049c2e11f";
    sha256 = "1r73mlrzj2l7288n6719ss0swayqh6xm0y6lygmiwyi9z5fdpnn5";
  };
  calendar = (pkgs.callPackage src {}).package;

  pinpkgs = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "7e9b0dff974c89e070da1ad85713ff3c20b0ca97";
    sha256 = "1ckzhh24mgz6jd1xhfgx0i9mijk6xjqxwsshnvq789xsavrmsc36";
  }) {};
in
{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/calendar.nix
  ];

  networking.firewall.allowedTCPPorts = [22 8080 9100];
  fonts.fontconfig.enable = pkgs.lib.mkForce true; # Make overridable?
  environment.systemPackages = [pinpkgs.chromium calendar];

  systemd.services.calendar = {
    wantedBy = ["multi-user.target"]; 
    after = ["network.target"];
    description = "Start the calendar service";
    environment = {
      NODE_ENV = "production";
      PORT = "8080";
      HOST = "0.0.0.0";
      BROWSER_PATH = "${pkgs.chromium}/bin/chromium";
    };
    serviceConfig = {
      Type = "simple";
      User = "calendar";
      Restart = "always";
      ExecStart = "${calendar}/bin/calendar";
    };
  };
}
