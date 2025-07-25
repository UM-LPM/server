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
      #"bioma2022.um.si" = {
      #  inherit email;
      #};
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
      "dev.collab.lpm.feri.um.si" = {
        inherit email;
      };
      "test.collab.lpm.feri.um.si" = {
        inherit email;
      };
      "pora.collab.lpm.feri.um.si" = {
        inherit email;
      };
      "rri.collab.lpm.feri.um.si" = {
        inherit email;
      };
      "vr.collab.lpm.feri.um.si" = {
        inherit email;
      };
      "collab.pmd.lpm.feri.um.si" = {
        inherit email;
      };
      "catalog.pmd.lpm.feri.um.si" = {
        inherit email;
      };
      "grades.lpm.feri.um.si" = {
        inherit email;
      };
      "katalog.krajsa-izobrazevanja.feri.um.si" = {
        inherit email;
      };
      "catalog.lpm.rwx.si" = {
        inherit email;
      };
      "catalog.catalog.lpm.rwx.si" = {
        inherit email;
      };
      "okkoreboot.com" = {
        inherit email;
      };
      "gc.lpm.feri.um.si" = {
        inherit email;
      };
      "sso-test.lpm.feri.um.si" = {
        inherit email;
      };
      "student-mqtt.lpm.feri.um.si" = {
        inherit email;
      };
      "cache.lpm.feri.um.si" = {
        inherit email;
      };
      "login.lpm.feri.um.si" = {
        inherit email;
      };
      "dev.login.lpm.feri.um.si" = {
        inherit email;
      };
      "feriusa.um.si" = {
        inherit email;
      };
      "feriusa.rwx.si" = {
        inherit email;
      };
      "students.lpm.feri.um.si" = {
        inherit email;
      };
      "pocitniske-sole.feri.um.si" = {
        inherit email;
      };
      "upravljanje.pocitniske-sole.feri.um.si" = {
        inherit email;
      };
      "upravljanje-katalog.lpm.feri.um.si" = {
        inherit email;
      };
      "school-project.rwx.si" = {
        inherit email;
      };
    };
    security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [80 443 1883 5050 8080 8883];
  networking.firewall.interfaces.ens2.allowedTCPPorts = [22 9100 9113];

  services.prometheus.exporters.nginx.enable = true;
  services.nginx.statusPage = true;

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
      #"bioma2022.um.si" = {
      #  #forceSSL = true;
      #  addSSL = true;
      #  enableACME = true;

      #  locations."/" = {
      #    proxyPass = "http://bioma.l:8080";
      #  };
      #};

      #"esp.lpm.feri.um.si" = {
      #  addSSL = true;
      #  sslCertificate = "/var/ssl/esp.lpm.feri.um.si.crt";
      #  sslCertificateKey = "/var/ssl/esp.lpm.feri.um.si.key";

      #  locations."/" = {
      #    proxyPass = "http://esp";
      #  };
      #};
      #"usatour.lpm.feri.um.si" = {
      #  locations."/" = {
      #    proxyPass = "http://usatour";
      #  };
      #};
      "ps.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://ps.l:5050/";
        };

        locations."/" = {
          proxyPass = "http://ps.l";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
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
        extraConfig = ''
          if ($host != $server_name) {
            return 444;
          }
        '';
      };
      "dev.collab.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true; 

        locations."/api/" = {
          proxyPass = "http://collab-dev.l:8080/api/";
        };
        locations."/" = {
          proxyPass = "http://collab-dev.l/";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
      };
      "pora.collab.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://collab-pora.l:8080/api/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://collab-pora.l/";
        };
      };
      "rri.collab.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://collab-rri.l:8080/api/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://collab-rri.l/";
        };
      };
      "vr.collab.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://collab-vr.l:8080/api/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://collab-vr.l/";
        };
      };
      "test.collab.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://collab-test.l:8080/api/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://collab-test.l/";
        };
      };
      "collab.pmd.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://collab-catalog-dev.l:8080/api/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://collab-catalog-dev.l/";
        };
      };
      "login.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/login-images/" = {
          recommendedProxySettings = true;
          proxyPass = "http://login.l/login-images/";
        };

        locations."/images/" = {
          recommendedProxySettings = true;
          proxyPass = "http://login.l/images/";
        };

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://login.l:3000/";
        };
      };
      "feriusa.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://feriusa.l/";
        };
      };
      "feriusa.rwx.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://feriusa.l/";
        };
      };
      "catalog.lpm.rwx.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://catalog-view.l/";
        };
        extraConfig = ''
          add_header Access-Control-Allow-Origin https://scms.catalog.lpm.rwx.si;
        '';
      };
      "students.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://usatour.l/";
        };
      };
      "dev.login.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/login-images/" = {
          recommendedProxySettings = true;
          proxyPass = "http://login-dev.l/login-images/";
        };

        locations."/images/" = {
          recommendedProxySettings = true;
          proxyPass = "http://login-dev.l/images/";
        };

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://login-dev.l:3000/";
        };
      };
      "catalog.pmd.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://catalog-dev.l:8080/api/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://catalog-dev.l/";
        };
      };
      "katalog.krajsa-izobrazevanja.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://catalog.l:8080/api/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://catalog.l/";
        };
      };
      "upravljanje-katalog.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://catalog-manage.l:8080/api/";
        };
        locations."/images/" = {
          proxyPass = "http://catalog-manage.l:8081/images/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://catalog-manage.l:8000/";
        };
      };
      "pocitniske-sole.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://catalog-summer-schools.l/";
        };
        extraConfig = ''
          add_header Access-Control-Allow-Origin upravljanje-katalog.lpm.feri.um.si;
          add_header Cache-Control "no-cache, must-revalidate";
        '';
      };
      "upravljanje.pocitniske-sole.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://catalog-summer-schools.l:8001/";
        };
        extraConfig = ''
          add_header Cache-Control "no-cache, must-revalidate";
        '';
      };
      "catalog.catalog.lpm.rwx.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://catalog-view.l:8001/";
        };
      };
      "school-project.rwx.si" = {
        addSSL = true;
        enableACME = true;

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://school-project.l/";
        };
      };
      "grades.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://grades.l:3003/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://grades.l/";
        };
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
      "cache.lpm.feri.um.si" = {
        addSSL = true;
        enableACME = true; 

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://builder.l/";
        };
      };
      "gc.lpm.feri.um.si" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://gc-dev.l:8080/api/";
        };
        locations."/documentation/" = {
          proxyPass = "http://gc-dev.l:8080/documentation/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://gc-dev.l/";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
      };
      "okkoreboot.com" = {
        #forceSSL = true;
        addSSL = true;
        enableACME = true;

        locations."/api/" = {
          proxyPass = "http://gc.l:8080/api/";
        };
        locations."/documentation/" = {
          proxyPass = "http://gc.l:8080/documentation/";
        };
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://gc.l/";
          extraConfig = ''
            add_header Cache-Control "no-store, no-cache, must-revalidate";
          '';
        };
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
      "calendar.rwx.si" = {
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
