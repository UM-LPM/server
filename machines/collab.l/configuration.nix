{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/collab.nix
  ];

  #services.restic.backups = {
  #  remote = {
  #    user = "collab";
  #    passwordFile = "/var/lib/restic-password";
  #    repository = "rclone:backup:/collab";
  #    rcloneConfigFile = "/var/lib/restic-rclone-config";
  #    initialize = true;
  #    paths = [
  #      "/home/collab/text.txt"
  #    ];
  #    timerConfig = {
  #      onCalendar = "tuesday 16:30";
  #    };
  #  };
  #};

  environment.systemPackages = [];
  networking.firewall.allowedTCPPorts = [22 80 8080 9100];

  noo.services.collab = {
    enable = true;
    jwtSecret = "ZYhOrjLhOsF9rr7LZUx0aTsm5H7ZlrxA0dmPKDPmXgZQoQ7nSY7IOOSlrHuCEtcB"; # XXX this is public
    adminDefaultPassword = "myadmindefaultpass";
  };
}
