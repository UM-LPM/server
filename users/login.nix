{config, lib, ...}:
{
  users.users.login = {
    isNormalUser = true;
    description = "Login user";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko cvetanka domen];
  };
}
