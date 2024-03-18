{config, lib, ...}:
{
  users.users."pmd-catalog" = {
    isNormalUser = true;
    description = "PMD catalog user";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko];
  };
}
