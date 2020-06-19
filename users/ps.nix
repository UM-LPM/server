{config, lib, ...}:
{
  security.sudo.wheelNeedsPassword = false;
  users.users.ps = {
    isNormalUser = true;
    description = "Ps user";
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga matej mario matej-actions];
  };
}
