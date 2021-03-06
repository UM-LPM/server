{config, lib, ...}:
{
  security.sudo.wheelNeedsPassword = false;

  users.users.esp = {
    isNormalUser = true;
    description = "Esp user";
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga matej mario matej-actions];
  };
}
