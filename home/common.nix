{ pkgs, lib, config, ... }:

with lib;
{

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-28.3.3"
      "electron-27.3.11"
    ];
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
        c = "clear";
      };
      bashrcExtra = ''
        eval "$(jump shell)"
        if command -v fzf-share >/dev/null; then
          source "$(fzf-share)/key-bindings.bash"
          source "$(fzf-share)/completion.bash"
        fi

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
      signing = {
        key = "0A1C5EFB232CD5BF6F0D7FA78765AA4E9A49249C";
        signByDefault = true;
      };
    };

    htop = {
      enable = true;
      settings.show_program_path = false;
    };

    alacritty = {
      enable = true;
      settings = {
        colors.normal ={
          black = "#f2f2f2";
          red = "#a60000";
          green = "#006800";
          yellow = "#6f5500";
          blue = "#0031a9";
          magenta = "#721045";
          cyan = "#005e8b";
          white = "#000000";
        };
        colors.bright = {
          black = "#c4c4c4";
          red = "#a0132f";
          green = "#00663f";
          yellow = "#7a4f2f";
          blue = "#0000b0";
          magenta = "#531ab6";
          cyan = "#005f5f";
          white = "#595959";
        };
        colors.cursor = {
          cursor = "#000000";
          text = "#ffffff";
        };
        colors.primary ={
          background = "#ffffff";
          foreground = "#000000";
        };
        colors.selection = {
          background = "#bdbdbd";
          text = "#000000";
        };

        font.size = 14;

        font.normal ={
          family = "Comic Mono";
          style = "Regular";
        };
      };
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

      logseq
      obsidian

      pgadmin
      tor
      inkscape

      rclone
      jetbrains.datagrip
      amberol
      jump
    ];
  };
}
