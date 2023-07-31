{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      autoLogin = {
        enable = false;
        user = "sho";
      };
    };
    desktopManager.plasma5.enable = true;
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
}
