{pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix>
  ];

  time.timeZone = "Europe/Ljubljana";

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  virtualisation.virtualbox.guest.x11 = false;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  boot.kernelParams = ["vga=0x31e"];

  programs.fish.enable = true;
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "user";
    shell = pkgs.fish;
  };
}
