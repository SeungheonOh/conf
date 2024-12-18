{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    unstable.follows = "nixpkgs";

    # nixpkgs-latest.url = "github:NixOS/nixpkgs/master";
    # nixpkgs-21_11.url = "github:NixOS/nixpkgs/21.11";
    nixpkgs-24_05.url = "github:NixOS/nixpkgs/24.05";

    fup.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    x1e-nixos-config.url = "path:/home/sho/conf/x1e-nixos-config";
    x1e-nixos-config.inputs.nixpkgs.follows = "nixpkgs";

    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    drmfilter.url = "path:/home/sho/Documents/drmfilter";

    monochromize.url = "path:/home/sho/Documents/drmfilterhs";
  };

  outputs = inputs@{ self, nixpkgs, unstable, nixpkgs-24_05, fup, home-manager, kmonad, x1e-nixos-config, drmfilter, monochromize }:
    let
      modules = import ./modules.nix { inherit fup; };
    in
      fup.lib.mkFlake {
        inherit self inputs;

        channels.nixpkgs.overlaysBuilder = channels: [
          (import ./overlays)
          (final: prev: {
  	        inherit (channels.nixpkgs-24_05) waybar xdg-desktop-portal xdg-desktop-portal-gtk kime;
            drmfilter = drmfilter.packages."aarch64-linux".default;
          })
        ];

        channelsConfig.allowUnfree = true;
        supportedSystems = [ "aarch64-linux" "x86_64-linux" ];

        hostDefaults.modules = [
          home-manager.nixosModules.home-manager
        ] ++ modules.sharedModules;

        hosts.Trajan.modules = with modules.configModules; [
          ./hosts/Trajan.nix
	        boot
          input
	        gnome
          docker
          ddns
	        network
	        bluetooth
          ({config, pkgs, lib, ...}: {
            services.avahi.enable = true;
            services.avahi.openFirewall = true;
            services.flatpak.enable = true;
            services.tailscale.enable = true;
            networking.firewall.allowedTCPPorts = [ 22 8384 22000 8096 ];
            networking.firewall.allowedUDPPorts = [ 22 22000 21027 51820 ];
            services.xrdp.enable = true;
            services.xrdp.defaultWindowManager = "${pkgs.icewm}/bin/icewm";
            services.xrdp.openFirewall = true;
            virtualisation.libvirtd.enable = true;
            programs.dconf.enable = true;

            environment.etc."X11/Xwrapper.config".text = ''
              allowed_users=anybody
            '';


            users.groups.lidarr = {};
            services = {
              openssh = {
                enable = true;
                settings.PasswordAuthentication = true;
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


	      hosts.Titus = {
	        system = "aarch64-linux";
	        modules = with modules.configModules;  [
	          x1e-nixos-config.nixosModules.x1e
            kmonad.nixosModules.default
            monochromize.nixosModules.default
	          sway
	          bluetooth
            input
	          ({pkgs, ...} :
              let
                x86 =
                  import nixpkgs {
	                  config.allowUnfree = true;
                    crossSystem = {
                      config = "x86_64-unknown-linux-gnu";
                    };
                  };
              in {
                time.timeZone = "America/Chicago";
                services.ntp.enable = true;

	              networking.hostName = "Titus";
	              hardware.deviceTree.name = "qcom/x1e80100-lenovo-yoga-slim7x.dtb";

	              nixpkgs.hostPlatform.system = "aarch64-linux";
	              nixpkgs.config.allowUnfree = true;

 	              networking.networkmanager = {
	                enable = true;
		              plugins = pkgs.lib.mkForce [];
	              };
	              security.rtkit.enable = true;

	              boot.loader = {
                  timeout = 0;
                  systemd-boot = {
	                  enable = true;
		                configurationLimit = 2;
	                };
                };

	              boot.initrd.systemd = {
	                enable = true;
		              emergencyAccess = true;
	              };

	              hardware.enableRedistributableFirmware = true;

                services.upower = {
                  enable = true;
                };

 	              fileSystems."/" =
 	                { device = "/dev/disk/by-label/root";
		                fsType = "ext4";
                  };

                fileSystems."/boot" =
                  { device = "/dev/disk/by-label/SYSTEM_DRV";
                    fsType = "vfat";
                  };

  	            xdg.portal = {
	                enable = true;
		              config = {
                    common = {
                      default = [
                        "gtk"
                      ];
                    };
		              };
		              configPackages = [
		                pkgs.gnome-session
		              ];
		              extraPortals = with pkgs; [
	                  xdg-desktop-portal-gtk
	                  xdg-desktop-portal-wlr
	                  xdg-desktop-portal-gnome
	                  xdg-desktop-portal
		              ];
                  wlr.enable = true;
	              };

	              environment.systemPackages = with pkgs; [
	                xdg-desktop-portal-gtk
	                xdg-desktop-portal-wlr
	                xdg-desktop-portal-gnome
	                xdg-desktop-portal
	              ];
	              programs.dconf.enable = true;

                # Silly xdg don't want to work
                systemd.user.services."xdg-desktop-portal-gtk".enable = false;
                # systemd.user.services."xdg-desktop-portal-gtk-mine" = {
                #   unitConfig = {
                #     PartOf = [ "graphical-session.target" ];
                #   };
                #   serviceConfig = {
                #     Type = "simple";
                #     ExecStart = "${pkgs.xdg-desktop-portal-gtk}/libexec/xdg-desktop-portal-gtk";
                #   };
                # };

                # systemd.services."monochromize" = {
                #   enable = true;

                #   before = [ "display-manager.service" ];
                #   wantedBy = [ "multi-user.target" ];
                #   serviceConfig = {
                #     ExecStart = "${pkgs.drmfilter}/bin/drmfilter";
                #     Type = "oneshot";
                #   };

                # };
                services.monochromize.enable = true;

	              boot.kernel.sysctl."kernel.sysrq" = 80;
                hardware.enableAllFirmware = true;
                hardware.firmware = [
                  pkgs.firmwareLinuxNonfree
                ];
                services.kmonad = {
                  enable = true;

                  keyboards.internal = {
                    device = "/dev/input/by-path/platform-b80000.i2c-event-kbd";
                    config = builtins.readFile ./keyboard/slim7x.kbd;

                    defcfg = {
                      enable = true;
                      fallthrough = true;
                      allowCommands = true;
                    };
                  };
                };
	            })
  	      ] ++ (modules.loadHome "sho" (with modules.homeModules; [
            haskellDev
          ]));
	      };

        hosts.Nerva.modules = with modules.configModules;  [
          kmonad.nixosModules.default
          ./hosts/Nerva.nix

	        boot
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
