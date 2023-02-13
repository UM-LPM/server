{config, pkgs, ...}:

{
  imports = [
    ../../modules/image.nix
    ../../users/root.nix
    ../../users/rescue.nix
    ../../users/sso-test.nix
  ];

  networking.firewall.allowedTCPPorts = [22 8080];

  services.ssoTest = {
    user = "sso-test";
    port = 8080;
    domain = "sso-test.lpm.feri.um.si";
    sessionSecret = pkgs.writeText "sessionSecret" "secret";
    samlCertificate = ./saml.crt;
    samlCertificateKey = config.age.secrets.saml-key.path;
    idpMetadata = builtins.fetchurl {
      url = "https://ds.aai.arnes.si/metadata/test-fed.arnes.si.signed.xml";
      sha256 = "1k7mzp516q0xap83aajpm72ykl4a8p4f036gzplczllps6pf6826";
    };
  };
}
