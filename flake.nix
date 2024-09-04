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

        channels.nixpkgs.overlaysBuilder = channels: [
          (import ./overlays)
          (final: prev: {
            # inherit (channels.nixpkgs-21_11) mpfr prusa-slicer openscad;
          })
        ];

        channelsConfig.allowUnfree = true;
        supportedSystems = [ "x86_64-linux" ];

        hostDefaults.modules = [
          home-manager.nixosModules.home-manager
        ] ++ modules.sharedModules;

	      hosts.Mars.modules = with modules.configModules; [
	        ./hosts/Mars.nix

          input
	        gnome
          docker
          ddns
          ({config, pkgs, lib, ...}: {
            services.printing.enable = true;
            services.printing.drivers = with pkgs; [ hplip ];
            services.avahi.enable = true;
            services.avahi.openFirewall = true;
            services.flatpak.enable = true;
            services.tailscale.enable = true;
            services.radarr = {
              enable = true;
              group = "lidarr";
            };
            services.jellyfin = {
              enable = false;
              group = "lidarr";
            };
            networking.firewall.allowedTCPPorts = [ 8384 22000 8096 ];
            networking.firewall.allowedUDPPorts = [ 22000 21027 51820 ];
            services.xrdp.enable = true;
            services.xrdp.defaultWindowManager = "${pkgs.icewm}/bin/icewm";
            services.xrdp.openFirewall = true;
            virtualisation.libvirtd.enable = true;
            programs.dconf.enable = true;

            environment.etc."X11/Xwrapper.config".text = ''
              allowed_users=anybody
            '';


            users.groups.lidarr = {};
            users.users."sho".openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOj5NShZ/AYRgNXKWU6sa4m/r3bFY0PoCIzPf1L1r7my sho@Mars"
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO6EpFDyBYtuGALqHyoOJ71HB72Ecn+IFFsDoRCiABAn sho@Hadrian"
            ];
            services = {
              openssh = {
                enable = true;
                settings.PasswordAuthentication = false;
              };
              syncthing = {
                enable = true;
                user = "sho";
                dataDir = "/home/sho/Logseq";
                configDir = "/home/sho/.config/syncthing";
                overrideDevices = true;
                overrideFolders = true;

                folders = {
                  "Logseq" = {
                    path = "/home/sho/Logseq";
                  };
                };
              };
            };
          })
	      ] ++ (modules.loadHome "sho" (with modules.homeModules; [
          haskellDev
          pursDev
          agdaDev
        ]));

        hosts.Nerva.modules = with modules.configModules;  [
          kmonad.nixosModules.default
          ./hosts/Nerva.nix

          input
          docker
          power
          # gnome
          sway
          bluetooth
          {
            home-manager.backupFileExtension = "backup";
            hardware.opengl.enable = true;
            networking.firewall.allowedTCPPorts = [ 3389 ];
            networking.firewall.allowedUDPPorts = [ 3389 ];

            time.timeZone = "America/Chicago";
  	        boot.initrd.luks.devices.luksroot = {
	            device = "/dev/disk/by-uuid/9438384c-f41b-4191-bd61-ced2b80360c9";
	            preLVM = true;
	            allowDiscards = true;
	          };
            services.kmonad = {
              enable = true;

              keyboards.internal = {
                device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
                config = builtins.readFile ./keyboard/framework13.kbd;

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
          #          pursDev
          agdaDev
          lispDev
          racketDev
          typescriptDev
        ]));
      };
}
