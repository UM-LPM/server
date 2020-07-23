{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/bridge.nix
    ../../users/root.nix
    ../../users/user.nix
  ];

  networking.bridge = {
    interface = "ens3";

    address = {
      address = "164.8.230.208";
      prefixLength = 24;
    };

    defaultGateway = {
      address = "164.8.230.1";
    };
  };

  #security.acme.email = "zigaleber7@gmail.com";

  security.acme.certs = {
    "umplatforma.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
    "test.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
    "ps.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
  };
  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [80 443];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [22];

  services.nginx = {
    enable = true;

    /*appendConfig = ''

      stream {
        map_hash_bucket_size 64;

        map $ssl_preread_server_name $target {
          umplatforma.lpm.feri.um.si accept;
          noodle.lpm.feri.um.si accept;
          default reject;
        }

        upstream accept {
          server localhost:10443;
        }

        upstream reject {
          server localhost:10000 down;
        }

        server {
          listen 443;
          ssl_preread on;

          proxy_pass $target;
        }
      }
    '';*/

    virtualHosts = {
      "umplatforma.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://spum-platform:5000/";
        };
        locations."/" = {
          proxyPass = "http://spum-platform";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
        extraConfig = ''
          if ($host != $server_name) {
            return 444;
          }
        '';
      };
      "esp.lpm.feri.um.si" = {
        addSSL = true;
        sslCertificate = "/var/ssl/esp.lpm.feri.um.si.crt";
        sslCertificateKey = "/var/ssl/esp.lpm.feri.um.si.key";
        
        locations."/" = {
          proxyPass = "http://esp";
        };
      };
      "ps.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;
        
        locations."/api/" = {
          proxyPass = "http://ps:5050/";
        }; 
        
        locations."/" = {
          proxyPass = "http://ps";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
        extraConfig = ''
          if ($host != $server_name) {
            return 444;
          }
        '';
      };
      "1.lpm.feri.um.si" = {
        locations."/" = {
          root = pkgs.runCommand "testdir" {} ''
            mkdir "$out"
            echo 'yes' > "$out/index.html"
          '';
        };
      };
      "test.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          root = pkgs.runCommand "testdir" {} ''
            mkdir "$out"
            echo '~' > "$out/index.html"
          '';
        };
      };
      "_" = {
        listen = [
          {addr="0.0.0.0"; port = 80; extraParameters = ["default_server"];}
        ];
        locations."/" = {
          return = "444";
        };
      };
    };

    mapHashBucketSize = 64;
    appendHttpConfig = ''
      types_hash_bucket_size 64;
      server_names_hash_bucket_size 64;
    ''; # Our domain names are too long, lol
  };
}
