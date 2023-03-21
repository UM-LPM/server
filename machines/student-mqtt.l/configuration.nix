{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22 9100 1883 8080];

  age.secrets."mqtt-passwords" = {
    owner = "mosquitto";
    group = "mosquitto";
    file = ../../secrets/mqtt-passwords.age;
  };

  services.mosquitto = {
    enable = true;
    includeDirs = [ # HACK: The module prevents you from setting password_file, so we use a custom configuration file
      (pkgs.linkFarm "mosquitto" {
        "mosquitto.conf" = (pkgs.writeText "mosquitto.conf" ''
          listener 1883 0.0.0.0
          password_file ${config.age.secrets.mqtt-passwords.path}
          listener 8080 0.0.0.0
          protocol websockets
          password_file ${config.age.secrets.mqtt-passwords.path}
        '');
      })
    ];
    listeners = []; # The default value in the module is incorrect (attrset)
  };
}
