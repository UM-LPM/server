{ modulesPath, config, pkgs, ... }: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
    ../../users/root.nix
    ../../users/login.nix
  ];

  networking.firewall.allowedTCPPorts = [22 80 443];

  age.secrets."login-aws-internal-secrets" = {
    file = ../../secrets/login-aws-internal-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  age.secrets."login-aws-external-secrets" = {
    file = ../../secrets/login-aws-external-secrets.age;
    mode = "600";
    owner = "login";
    group = "users";
  };

  security.acme.certs =
    let email = "ziga.leber@um.si"; in
    {
      "login.lpm.rwx.si" = {
        inherit email;
      };
    };
  security.acme.acceptTerms = true;

  services.nginx =
    let
       proxySelfConfig = host: pkgs.writeText "proxy-self" ''
         proxy_set_header Host ${host};
         proxy_set_header X-Original-Host $http_host;
         proxy_set_header X-Original-Scheme $scheme;
         proxy_set_header X-Forwarded-For $remote_addr;
       '';
    in {
    enable = true;

    virtualHosts = {
      "login.lpm.rwx.si" = {
        addSSL = true;
        enableACME = true;

        locations."/login-images/" = {
          proxyPass = "http://localhost/login-images/";
          extraConfig = ''
            include ${proxySelfConfig "login-locale-pictures"};
          '';
        };

        locations."/images/" = {
          proxyPass = "http://localhost/images/";
          extraConfig = ''
            include ${proxySelfConfig "login-locale-pictures"};
          '';
        };

        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://localhost:3000/";
        };
      };
    };
  };

  noo.services.login = {
    enable = true;

    profilePictures = {
      enable = true;
      address = "https://login.lpm.rwx.si";
      host = "login-locale-pictures";
    };

    service = {
      enable = true;
      address = "https://login.lpm.rwx.si";
      internalSecretsFile = config.age.secrets.login-aws-internal-secrets.path;
      externalSecretsFile = config.age.secrets.login-aws-external-secrets.path;
    };
    database.enable = true;
  };

  system.stateVersion = "24.05";
}
