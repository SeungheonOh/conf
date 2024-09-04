{ fup }:
with fup.lib;
let
  configModules = exportModules [
    # Nix Configuration (shared)
    ./config/boot.nix
    ./config/font.nix
    ./config/nix.nix
    ./config/programs.nix
    ./config/network.nix
    ./config/power.nix
    ./config/sho.nix
    ./config/udev.nix

    # Not shared
    ./config/input.nix
    ./config/docker.nix
    ./config/gnome.nix
    ./config/sway.nix
    ./config/kde.nix
    ./config/ddns.nix
    ./config/bluetooth.nix
  ];

  homeModules = exportModules [
    # Home-manager (shared)
    ./home/common.nix

    # Not shared
    ./home/haskellDev.nix
    ./home/pursDev.nix
    ./home/agdaDev.nix
    ./home/lispDev.nix
    ./home/racketDev.nix
    ./home/typescriptDev.nix
  ];
in
rec {
  inherit configModules homeModules;

  loadHome = user: hmodules:
    map (hm:
      ({ pkgs, lib, config, ... }: {
        home-manager.users."${user}" = hm;
      })
    ) hmodules;

  sharedModules = with configModules; [
    # config
    boot
    font
    programs
    nix
    network
    udev
    sho
  ] ++ (loadHome "sho" (with homeModules; [
    common
  ]));
}
