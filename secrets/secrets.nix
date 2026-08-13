let
  users = import ../ssh/users.nix;
  systems = builtins.mapAttrs (_: value: value.key) (import ../ssh/systems.nix);
in
{
  "saml-key.age".publicKeys = [systems."sso-test.l"] ++ (with users; [mario ziga matej cvetanka]);
  "oidc-key.age".publicKeys = [systems."sso-test.l"] ++ (with users; [mario ziga matej cvetanka]);
  "cache-key.age".publicKeys = [systems."builder.l"] ++ (with users; [mario ziga matej cvetanka]);
  "collab-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga matej cvetanka]);
  "login-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "grades-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "catalog-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "catalog-registration-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "ears-runner-token.age".publicKeys = [systems."ears.l"] ++ (with users; [mario ziga marko matej miha cvetanka]);
  "mqtt-passwords.age".publicKeys = [systems."student-mqtt.l"] ++ (with users; [mario ziga matej cvetanka]);
  "login-internal-secrets.age".publicKeys = [systems."login.l"] ++ (with users; [mario ziga matej marko cvetanka]);
  "login-external-secrets.age".publicKeys = [systems."login.l"] ++ (with users; [mario ziga matej marko cvetanka]);
  "login-dev-internal-secrets.age".publicKeys = [systems."login-dev.l"] ++ (with users; [mario ziga matej marko cvetanka]);
  "login-dev-external-secrets.age".publicKeys = [systems."login-dev.l"] ++ (with users; [mario ziga matej marko cvetanka]);
  "login-aws-internal-secrets.age".publicKeys = [systems."lpm.rwx.si"] ++ (with users; [mario ziga matej marko cvetanka]);
  "login-aws-external-secrets.age".publicKeys = [systems."lpm.rwx.si"] ++ (with users; [mario ziga matej marko cvetanka]);
  "gc-secrets.age".publicKeys = [systems."gc.l" systems."gc-dev.l"] ++ (with users; [mario ziga matej marko cvetanka]);
  "pmd-catalog-secrets.age".publicKeys = [systems."pmd-catalog.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "catalog-secrets.age".publicKeys = [systems."catalog.l" systems."catalog-dev.l" systems."catalog-manage.l" systems."catalog-manage-dev.l" systems."catalog-manage-um.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "collab-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "collab-external-secrets.age".publicKeys = [systems."collab-dev.l" systems."collab-pora.l" systems."collab-rri.l" systems."collab-vr.l" systems."collab-rsasm.l" systems."collab-catalog-dev.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "catalog-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "grades-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "cms-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka]);
  "grades-dev-client-secret.age".publicKeys = [systems."login-dev.l" systems."login.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "grades-external-secrets.age".publicKeys = [systems."grades.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "grades-dev-external-secrets.age".publicKeys = [systems."grades-dev.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "backup-rclone-config.age".publicKeys = [systems."catalog-manage.l" systems."catalog-manage-dev.l" systems."catalog-manage-um.l" systems."grades.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
  "backup-password.age".publicKeys = [systems."catalog-manage.l" systems."catalog-manage-dev.l" systems."catalog-manage-um.l" systems."grades.l"] ++ (with users; [mario ziga marko matej cvetanka domen]);
}
