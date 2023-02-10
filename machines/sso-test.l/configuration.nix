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
      url = "https://ds.aai.arnes.si/metadata/aai.arnes.si.sha256.xml";
      sha256 = "0w6ww213cjzxlya8bb47gdx8vqcp1wif6ycsymlxggvi1i8gc87i";
    };
  };
}
