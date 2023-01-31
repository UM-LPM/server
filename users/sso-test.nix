{config, lib, ...}:
{
  users.users.sso-test = {
    isNormalUser = true;
    description = "SSO-test user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej];
  };
}
