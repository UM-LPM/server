{config, pkgs, ...}:

let
  src = pkgs.fetchFromGitHub {
    owner = "brokenpylons";
    repo = "Calendar";
    rev = "7085ae0be638751af4872714bb50e9e7b6499132";
    sha256 = "0daxijvn0n8g9nb525jbxqsx8gj0d7caafay5vgfz181vjlwkvqk";
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
