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

  networking.hostName = "gateway";
  networking.firewall.allowedTCPPorts = [80];
  networking.firewall.interfaces.ens3.allowedTCPPorts = [22];

  services.nginx = {
    enable = true;

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

    appendHttpConfig = ''
      server_names_hash_bucket_size 64;
    ''; # Our domain names are too long, lol

  };
}
