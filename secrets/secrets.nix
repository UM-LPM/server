let
  users = import ../ssh/users.nix;
  systems = import ../ssh/systems.nix;
in
{
  "saml-key.age".publicKeys = [systems."sso-test.l"] ++ (with users; [mario ziga matej]);
  "oidc-key.age".publicKeys = [systems."sso-test.l"] ++ (with users; [mario ziga matej]);
  "cache-key.age".publicKeys = [systems."builder.l"] ++ (with users; [mario ziga matej]);
  "collab-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga matej]);
  "login-runner-token.age".publicKeys = [systems."runner1.l"] ++ (with users; [mario ziga marko matej]);
  "mqtt-passwords.age".publicKeys = [systems."student-mqtt.l"] ++ (with users; [mario ziga matej]);
  "login-secrets.age".publicKeys = [systems."login.l"] ++ (with users; [mario ziga matej marko]);
  "gc-secrets.age".publicKeys = [systems."gc.l"] ++ (with users; [mario ziga matej marko]);
}
