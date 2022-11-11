{config, lib, ...}:
{
  users.users.green = {
    isNormalUser = true;
    description = "Green project user";
    extraGroups = ["wheel"];

    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej ziga-actions miha];
  };
}
