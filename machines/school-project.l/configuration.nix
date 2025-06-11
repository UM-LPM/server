{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../modules/base.nix
    ../../users/root.nix
    ../../users/school-project.nix
    ../../users/rescue.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 9100];

  services.phpfpm.pools.school-project = {
    user = "schoolproject";
    settings = {
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 4;
      "pm.max_requests" = 500;
      "listen.owner" = config.services.nginx.user;
      "listen.group" = config.services.nginx.group;
      "listen.mode" = "0660";
      "catch_workers_output" = 1;
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts."$hostname" = {
      root = "/var/www";

      extraConfig = ''
          index index.php;
      '';

      locations."~ ^(.+\\.php)(.*)$"  = {
        extraConfig = ''
          try_files $fastcgi_script_name =404;
          include ${config.services.nginx.package}/conf/fastcgi_params;
          fastcgi_split_path_info  ^(.+\.php)(.*)$;
          fastcgi_pass unix:${config.services.phpfpm.pools.school-project.socket};
          fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
          fastcgi_param PATH_INFO       $fastcgi_path_info;

          include ${pkgs.nginx}/conf/fastcgi.conf;
        '';
      };
    };
  };

  systemd.tmpfiles.settings = {
    "10-root" = {
      "/var/www" = {
        d = {
          group = config.services.nginx.user;
          mode = "0755";
          user = config.services.nginx.group;
        };
      };
    };
  };

  services.oidentd.enable = true;

  services.postgresql = {
     enable = true;
     authentication = ''
       local all all peer
       host schoolproject schoolproject localhost ident
     '';
     ensureDatabases = ["schoolproject"];
     ensureUsers = [
       {
         name = "schoolproject";
         ensureDBOwnership = true;
       }
     ];
  };
}
