{config, lib, ...}:
{
  security.sudo.wheelNeedsPassword = false;
  users.users.spum = {
    isNormalUser = true;
    description = "Spum user";
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga dragana matej dragana-actions matej-actions];
  };
}
