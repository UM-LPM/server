{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/user.nix
    ../../users/spum.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100 1883];

  services.mosquitto = {
    enable = true;
    host = "0.0.0.0";
    users = {};
    extraConf = ''
      password_file /var/lib/mosquitto/passwd
    '';
  };
}
