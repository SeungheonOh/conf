{ config, lib, pkgs, ... }:{
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    rofi-wayland
    foot
    libinput-gestures
    kanshi
    playerctl
    pulseaudio
    waybar
    nautilus

    glib
    gsettings-desktop-schemas
  ];

  services.gvfs.enable = true;

  xdg = {
    portal = {
      enable = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    settings = {
      allow-emacs-pinentry = "";
      allow-loopback-pinentry = "";
    };
    pinentryPackage = pkgs.pinentry-tty;
    enableSSHSupport = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session =
        let
          schema = pkgs.gsettings-desktop-schemas;
          datadir = "${schema}/share/gsettings-schemas/${schema.name}";
        in {
          command = ''
            #silly
            export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
            ${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk &
            ${pkgs.sway}/bin/sway
          '';
          user = "sho";
        };
      default_session = initial_session;
    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.etc."greetd/environments".text = ''
    sway
    bash
  '';

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c /home/sho/.config/sway/kanshi.conf'';
    };
  };

  systemd.targets.network-online.wantedBy = [];
}
