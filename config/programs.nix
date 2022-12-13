{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mg
    emacs
    git
    wget
    firefox
    dmenu
    acpi
    brightnessctl
    pavucontrol
    pamixer
    libnotify
    zoom-us
  ];
}
