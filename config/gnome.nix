{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = false;
        user = "sho";
      };
    };
    desktopManager.gnome.enable = true;
  };
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-characters
    gnome-contacts
    gnome-initial-setup
  ]);
  programs.dconf.enable = true;
  programs.gnome-terminal.enable = true;
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.openweather
    gnomeExtensions.vertical-workspaces
  ];
}
