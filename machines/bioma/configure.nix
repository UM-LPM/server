{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/docker-auto-clean.nix 
    ../../users/root.nix
    ../../users/user.nix
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
          root = pkgs.runCommand "source" {} ''
            mkdir "$out"
            echo 'bioma' > "$out/index.html"
          '';
        };
      };
    };
  };
}
