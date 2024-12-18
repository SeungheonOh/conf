{ config, lib, pkgs, ... }:
{
  services.udev.packages = with pkgs; [
  ];
  programs.mosh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  #programs.steam.enable = true;
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
#    zoom-us -- figure out how to deal with this elegantly
    killall

    chromium

    jq
    flameshot

    easyeffects

    cachix

    openscad

    texlive.combined.scheme-full
    texlive.bin.pygmentex

    gnupg
    pinentry
    kleopatra

    doppler

    (python3.withPackages(ps: with ps; [ pandas matplotlib numpy jupyter ]))

    telegram-desktop

    alacritty
  ];
}
