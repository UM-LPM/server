{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/bridge.nix
    ../../users/root.nix
    ../../users/user.nix
  ];

  networking.bridge = {
    interface = "ens4";

    address = {
      address = "164.8.230.208";
      prefixLength = 24;
    };

    defaultGateway = {
      address = "164.8.230.1";
    };
  };

  #security.acme.email = "zigaleber7@gmail.com";
  #security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [80];

  services.nginx = {
    enable = true;

    appendHttpConfig = ''
      access_log syslog:server=unix:/dev/log combined;
      server_names_hash_bucket_size 64;
    '';# Our domain names are too long, lol

    virtualHosts = 
    let
      mkHost = addr: {
        #addSSL = true; # XXX: add force
        #enableACME = true;

        locations."/" = {
          proxyPass = addr;
        };
      };
    in
    {
      #"test.lpm.feri.um.si" = mkHost "http://10.17.3.2"; 
      "noodle.lpm.feri.um.si" = {

        locations."/" = {
          root = pkgs.runCommand "testdir" {} ''
            mkdir "$out"
            echo '~' > "$out/index.html"
          '';
        };
      };
    };
  };
}
