{config, lib, ...}:
{
  users.users.gb = {
    isNormalUser = true;
    description = "Game backend user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej gb];
  };
}
