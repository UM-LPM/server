{config, lib, ...}:
{
  users.users.bioma = {
    isNormalUser = true;
    description = "Bioma user";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej bioma-actions];
  };
}
