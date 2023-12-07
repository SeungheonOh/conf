{ config, lib, pkgs, ... }:
{
  programs.mosh.enable = true;
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
    killall

    chromium

    jq
    flameshot

    easyeffects

    cachix

    openscad
    prusa-slicer
    insomnia
    ngrok

    texlive.combined.scheme-full

    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
    virtmanager
    etcher

    vscodium
    (python3.withPackages(ps: with ps; [ pandas matplotlib numpy jupyter ]))
  ];
}
