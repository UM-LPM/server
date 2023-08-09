{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/rescue.nix
  ];

  security.polkit.enable = true;
  boot.kernelModules = ["kvm-intel"];
  virtualisation.libvirtd.enable = true;

  networking.firewall.allowedTCPPorts = [22 80];

  age.secrets."cache-key".file = ../../secrets/cache-key.age;

  services.nix-serve = {
    enable = true;
    secretKeyFile = config.age.secrets.cache-key.path;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "$hostname" = {
        locations."/".proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      };
    };
  };
}
