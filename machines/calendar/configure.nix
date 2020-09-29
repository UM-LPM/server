{config, pkgs, ...}:

let
  src = pkgs.fetchFromGitHub {
    owner = "brokenpylons";
    repo = "Calendar";
    rev = "73e951b3191dfd3fcb864fe7422dc2d66f76d78e";
    sha256 = "00yiq9xldbmmgr74syf71ilpi5gqfi9q52r83syy764xdxfni473";
  };
  calendar = (pkgs.callPackage src {}).package;
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
  environment.systemPackages = [pkgs.chromium calendar];

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
