{ config, lib, pkgs, ... }:
{
  services.udev.packages = with pkgs; [
    via
  ];
  programs.mosh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.steam.enable = true;
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
    texlive.bin.pygmentex

    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull
    virt-manager

    gnupg
    pinentry
    kleopatra

    doppler

    nyxt

    via

    vscodium
    (python3.withPackages(ps: with ps; [ pandas matplotlib numpy jupyter ]))

    telegram-desktop
    nuclear
    spotify

    alacritty
  ];
}
