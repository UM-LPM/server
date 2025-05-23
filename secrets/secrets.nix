let
  users = import ../ssh/users.nix;
  systems = builtins.mapAttrs (_: value: value.key) (import ../ssh/systems.nix);
in
{
  "saml-key.age".publicKeys = [systems."sso-test.l"] ++ (with users; [mario ziga matej]);
  "oidc-key.age".publicKeys = [systems."sso-test.l"] ++ (with users; [mario ziga matej]);
  "cache-key.age".publicKeys = [systems."builder.l"] ++ (with users; [mario ziga matej]);
  "collab-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga matej]);
  "login-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej]);
  "grades-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej]);
  "catalog-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej]);
  "ears-runner-token.age".publicKeys = [systems."ears.l"] ++ (with users; [mario ziga marko matej miha]);
  "mqtt-passwords.age".publicKeys = [systems."student-mqtt.l"] ++ (with users; [mario ziga matej]);
  "login-internal-secrets.age".publicKeys = [systems."login.l"] ++ (with users; [mario ziga matej marko]);
  "login-external-secrets.age".publicKeys = [systems."login.l"] ++ (with users; [mario ziga matej marko]);
  "login-dev-internal-secrets.age".publicKeys = [systems."login-dev.l"] ++ (with users; [mario ziga matej marko]);
  "login-dev-external-secrets.age".publicKeys = [systems."login-dev.l"] ++ (with users; [mario ziga matej marko]);
  "login-aws-internal-secrets.age".publicKeys = [systems."lpm.rwx.si"] ++ (with users; [mario ziga matej marko]);
  "login-aws-external-secrets.age".publicKeys = [systems."lpm.rwx.si"] ++ (with users; [mario ziga matej marko]);
  "gc-secrets.age".publicKeys = [systems."gc.l" systems."gc-dev.l"] ++ (with users; [mario ziga matej marko]);
  "pmd-catalog-secrets.age".publicKeys = [systems."pmd-catalog.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "catalog-secrets.age".publicKeys = [systems."catalog.l" systems."catalog-dev.l" systems."catalog-manage.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "collab-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "catalog-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "grades-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
}
