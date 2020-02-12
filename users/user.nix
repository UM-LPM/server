{config, lib, ...}:
{
  users.users.user = {
    isNormalUser = true;
    description = "Default user";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga];
  };
}
