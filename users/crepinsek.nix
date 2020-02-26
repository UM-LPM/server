{config, lib, ...}:
{
  security.sudo.wheelNeedsPassword = false;
  users.users.spum = {
    isNormalUser = true;
    description = "Crepinsek family";
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga matej];
  };
}
