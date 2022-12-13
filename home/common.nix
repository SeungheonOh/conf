{ pkgs, lib, config, ... }:

with lib;
let
  browser = [ "firefox.desktop" ];
    associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
    "image/*" = "org.gnome.eog.desktop";

    "text/*" = [ "emacs.desktop" ];
    "audio/*" = [ "vlc.desktop" ];
    "video/*" = [ "vlc.dekstop" ];
    "application/json" = browser; # ".json"  JSON format
    "application/pdf" = browser; # ".pdf"  Adobe Portable Document Format (PDF)
    "x-scheme-handler/tg" = "userapp-Telegram Desktop-95VAQ1.desktop";
  };
in
{
  nixpkgs = {
    config.allowUnfree = true;
  };

  home.stateVersion = "22.11";
  home.keyboard.options = [ "eurosign:e" ];

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
    EDITOR = "mg";
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = associations;
  xdg.mimeApps.defaultApplications = associations;

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    bash = {
      enable = true;
      shellAliases = {
        nr = "nix run";
        nfl = "nix flake lock";
        nfu = "nix flake update";
        nd = "nix develop";
      };
      bashrcExtra = ''
        if [ $SHLVL -ne 1 ]; then
          export PS1="[$SHLVL] \W $ "
        else
          export PS1="\W $ "
        fi
      '';
    };

    git = {
      enable = true;
      userName = "Seungheon Oh";
      userEmail = "seungheon.ooh@gmail.com";
    };

    htop = {
      enable = true;
      settings.show_program_path = false;
    };
  };

  services = {
    unclutter.enable = true;
  };

  home = {
    username = "sho";
    homeDirectory = "/home/sho";
    packages = with pkgs; [
      gh
      pandoc
      libreoffice
      unzip
      zip
      fzf
      tree
      vlc
      feh
      nixfmt
      slack
      discord
      (hunspellWithDicts (with hunspellDicts; [en-us-large]))
      mtm
      steam
    ];
  };
}
