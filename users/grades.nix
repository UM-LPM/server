{config, lib, ...}:
{
  users.users.grades = {
    isNormalUser = true;
    description = "Grading app";
    openssh.authorizedKeys.keys = with import ../ssh-keys.nix; [ziga matej mario domen];
  };
}
