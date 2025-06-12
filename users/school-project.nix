{config, lib, ...}:
{
  users.users.schoolproject = {
    isNormalUser = true;
    description = "School project user";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [mario ziga matej martin];
  };
}
