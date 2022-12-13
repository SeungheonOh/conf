{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    unstable.follows = "nixpkgs";

    # nixpkgs-latest.url = "github:NixOS/nixpkgs/master";
    # nixpkgs-21_11.url = "github:NixOS/nixpkgs/21.11";

    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, unstable, fup, home-manager, kmonad }:
    let
      modules = import ./modules.nix { inherit fup; };
    in
      fup.lib.mkFlake {
        inherit self inputs;
        channelsConfig.allowUnfree = true;
        supportedSystems = [ "x86_64-linux" ];

        hostDefaults.modules = [
          home-manager.nixosModules.home-manager
        ] ++ modules.sharedModules;

        hosts.Hadrian.modules = with modules.configModules;  [
          kmonad.nixosModules.default
          ./hosts/Hadrian.nix

          power
          gnome
          {
            services.kmonad = {
              enable = true;

              keyboards.internal = {
                device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
                config = builtins.readFile ./keyboard/thinkpad_internal.kbd;

                defcfg = {
                  enable = true;
                  fallthrough = true;
                  allowCommands = true;
                };
              };
            };
          }
        ] ++ (modules.loadHome "sho" (with modules.homeModules; [
          haskellDev
          pursDev
          agdaDev
        ]));
      };
}
