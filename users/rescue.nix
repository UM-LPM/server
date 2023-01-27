{config, lib, ...}:
{
  # This user cannot login via SSH
  security.sudo.wheelNeedsPassword = false;
  users.users.rescue = {
    isNormalUser = true;
    description = "Rescue user";
    extraGroups = ["wheel"];
    password = "rescue";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [mario ziga matej];
  };
}
