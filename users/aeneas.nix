{config, lib, ...}:
{
  users.users.aeneas = {
    isNormalUser = true;
    description = "Aeneas project user";
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej ziga-actions];
  };
}
