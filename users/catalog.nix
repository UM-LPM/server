{config, lib, ...}:
{
  users.users.catalog = {
    isNormalUser = true;
    description = "PMD catalog user";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej marko cvetanka];
  };
}
