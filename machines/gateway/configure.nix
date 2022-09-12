{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/bridge-new.nix
    ../../users/root.nix
    ../../users/user.nix
  ];

  networking.bridge = {
    interface = "ens3";

    addresses = [ 
      {
        address = "164.8.230.208";
        prefixLength = 24;
      }
      {
        address = "164.8.230.210";
        prefixLength = 24;
      }
    ];

    defaultGateway = {
      address = "164.8.230.1";
    };
  };

  #security.acme.email = "zigaleber7@gmail.com";

  security.acme.certs = {
    "bioma2022.um.si".email = "zigaleber7@gmail.com"; 
    "umplatforma.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
    "test.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
    "ps.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
    "collab.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
    "gb.lpm.feri.um.si".email = "zigaleber7@gmail.com"; 
  };
  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [80 443 1883];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [22 9100];

  services.nginx = {
    enable = true;

    appendConfig = ''
      stream {
        server {
          listen 164.8.230.210:1883;
          proxy_pass spum-mqtt:1883;
        }
      }
    '';
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
      };
      "bioma2022.um.si" = {
        forceSSL = true;
        #addSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://bioma:8080";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
      };
      "esp.lpm.feri.um.si" = {
        addSSL = true;
        sslCertificate = "/var/ssl/esp.lpm.feri.um.si.crt";
        sslCertificateKey = "/var/ssl/esp.lpm.feri.um.si.key";
        
        locations."/" = {
          proxyPass = "http://esp";
        };
      };
       "usatour.lpm.feri.um.si" = {
        locations."/" = {
          proxyPass = "http://usatour";
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
      "collab.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;
        
        locations."/api/" = {
          proxyPass = "http://collab:5050/";
        }; 
        
        locations."/" = {
          proxyPass = "http://collab";
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
      "gb.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;
        
        locations."/api/" = {
          proxyPass = "http://gb:5050/";
        }; 
        
        locations."/" = {
          proxyPass = "http://gb";
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
          proxyPass = "http://spum-platform";
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
      "calendar.brokenpylons.com" = {
        locations."/" = {
          proxyPass = "http://calendar:8080/";
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
