{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/sso-test.nix
  ];

  networking.firewall.allowedTCPPorts = [22 8080];

  age.secrets."saml-key" = {
    owner = "sso-test";
    group = "users";
    file = ../../secrets/saml-key.age;
  };
  age.secrets."oidc-key".file = ../../secrets/oidc-key.age;

  services.ssoTest = {
    user = "sso-test";
    port = 8080;
    domain = "sso-test.lpm.feri.um.si";
    sessionSecret = pkgs.writeText "sessionSecret" "secret";
    samlCertificate = ./saml.crt;
    samlCertificateKey = config.age.secrets.saml-key.path;
    idpMetadata = builtins.fetchurl {
      url = "https://ds.aai.arnes.si/metadata/aai.arnes.si.sha256.xml";
      sha256 = "0gy3b0vnnv9ihqd3g4klvd9l97x8caf0szndq0pv6p731mkm1cdy";
    };
  };
}
