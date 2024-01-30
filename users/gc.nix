{config, lib, ...}:
{
  users.users.gc = {
    isNormalUser = true;
    description = "GC user";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko];
  };
}
