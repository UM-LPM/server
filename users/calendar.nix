{config, lib, ...}:
{
  users.users.calendar = {
    isNormalUser = true;
    description = "Calendar user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga];
  };
}
