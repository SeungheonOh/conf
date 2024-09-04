{ config, lib, pkgs, ... }:{
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
  ];

  xdg = {
    portal = {
      enable = true;
      gtkUsePortal = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;
    enableSSHSupport = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "sho";
      };
      default_session = initial_session;
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
    bash
  '';

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c /home/sho/.config/sway/kanshi.conf'';
    };
  };

  systemd = {
    targets.network-online.wantedBy = pkgs.lib.mkForce []; # Normally ["multi-user.target"]
    services.NetworkManager-wait-online.wantedBy = pkgs.lib.mkForce []; # Normally ["network-online.target"]
    services."tailscaled".wantedBy = pkgs.lib.mkForce [];
    services."docker".wantedBy = pkgs.lib.mkForce [];
    services."firewall".wantedBy = pkgs.lib.mkForce [];
    services."libvirtd".wantedBy = pkgs.lib.mkForce [];
  };
}
