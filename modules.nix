{ fup }:
with fup.lib;
let
  configModules = exportModules [
    # Nix Configuration (shared)
    ./config/boot.nix
    ./config/font.nix
    ./config/input.nix
    ./config/nix.nix
    ./config/programs.nix
    ./config/network.nix
    ./config/power.nix
    ./config/sho.nix

    # Not shared
    ./config/docker.nix
    ./config/gnome.nix
  ];

  homeModules = exportModules [
    # Home-manager (shared)
    ./home/common.nix

    # Not shared
    ./home/haskellDev.nix
    ./home/pursDev.nix
    ./home/agdaDev.nix
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
    input
    programs
    nix
    network
    sho
  ] ++ (loadHome "sho" (with homeModules; [
    common
  ]));
}
