{config, pkgs, ...}:
{
  age.secrets."saml-key" = {
    owner = "sso-test";
    group = "users";
    file = ../secrets/saml-key.age;
  };
  age.secrets."oidc-key".file = ../secrets/oidc-key.age;
}
