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
    alacritty
    brightnessctl
    pavucontrol
    pamixer
    libnotify
    zoom-us
  ];
}
