{config, lib, pkgs, ...}:
{
  users.users.bastion = {
    isNormalUser = true;
    description = "Bastion user";
    shell = "${pkgs.shadow}/bin/nologin";
    openssh.authorizedKeys.keys = with import ../ssh/users.nix; [
      mario ziga matej miha dragana bostjan marko viktor server-actions bioma-actions bass-actions matej-actions dragana-actions matej-extra
    ];
  };
}
