{ pkgs, lib, config, ... }:

with lib;
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

      logseq
      obsidian

      pgadmin
      tor
      inkscape

      rclone
      jetbrains.datagrip
    ];
  };
}
