{config, lib, ...}:
{
  users.users.usatour = {
    isNormalUser = true;
    description = "Legacy FERI USA user";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko cvetanka];
  };
}
