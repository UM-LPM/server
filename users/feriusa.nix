{config, lib, ...}:
{
  users.users.feriusa = {
    isNormalUser = true;
    description = "Feri USA user";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko cvetanka];
  };
}
