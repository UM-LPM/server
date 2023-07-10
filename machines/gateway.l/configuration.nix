{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../modules/bridge.nix
    ../../users/root.nix
    ../../users/rescue.nix
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
      {
        address = "164.8.230.211";
        prefixLength = 24;
      }
    ];

    defaultGateway = {
      address = "164.8.230.1";
    };
  };

  #security.acme.email = "zigaleber7@gmail.com";

  security.acme.certs =
    let email = "ziga.leber@um.si"; in
    {
      "bioma2022.um.si" = {
        inherit email;
      };
      "umplatforma.lpm.feri.um.si" = {
        inherit email;
      };
      "test.lpm.feri.um.si" = {
        inherit email;
      };
      "ps.lpm.feri.um.si" = {
        inherit email;
      };
      "collab.lpm.feri.um.si" = {
        inherit email;
      };
      "gb.lpm.feri.um.si" = {
        inherit email;
      };
      "sso-test.lpm.feri.um.si" = {
        inherit email;
      };
      "student-mqtt.lpm.feri.um.si" = {
        inherit email;
      };
    };
    security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [80 443 1883 5050 8080 8883];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [22 9100];

  services.nginx = {
    enable = true;

    appendConfig =
      let
        certs = config.security.acme.certs;
        certName = "student-mqtt.lpm.feri.um.si";
        sslCertificate = "${certs.${certName}.directory}/fullchain.pem";
        sslCertificateKey = "${certs.${certName}.directory}/key.pem";
      in
      ''
        stream {
          server {
            listen 164.8.230.210:1883;
            proxy_pass spum-mqtt:1883;
          }
          server {
            listen 164.8.230.211:1883;
            proxy_pass student-mqtt.l:1883;
          }
          server {
            listen 164.8.230.211:8883 ssl;
            proxy_pass student-mqtt.l:1883;
            ssl_certificate ${sslCertificate};
            ssl_certificate_key ${sslCertificateKey};
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
        #forceSSL = true;
        addSSL = true;
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
      "student-mqtt.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://student-mqtt.l:8080";
          extraConfig = ''
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "Upgrade";
          '';
        };
      };
      "collab.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true; 

        locations."/api/" = {
          proxyPass = "http://collab.l:8080/api/";
        };
        locations."/" = {
          proxyPass = "http://collab.l/";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
        locations."/dev/api/" = {
          proxyPass = "http://collab-dev.l:8080/api/";
        };
        locations."/dev/" = {
          proxyPass = "http://collab-dev.l/";
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
      "sso-test.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true; 

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://sso-test.l:8080/";
          extraConfig = ''
            allow 164.8.230.192/26;
            deny all;
          '';
        };
      };
      "gb.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;
        
        locations."/" = {
          proxyPass = "http://gb:8080/";
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
          root = "/var/serve/";
        };
      };
      "calendar.brokenpylons.com" = {
        locations."/" = {
          proxyPass = "http://calendar.l:8080/";
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
