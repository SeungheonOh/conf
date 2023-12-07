{ config, lib, pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  system.stateVersion = "22.11";
  nix = {
    package = pkgs.nixVersions.unstable;
    optimise.automatic = true;
    gc = {
      automatic = false;
      options = ''
        --delete-older-than 14d
      '';
    };

    settings = {
      substituters = [
        "https://liqwid.cachix.org"
        "https://cache.nixos.org"
        "https://cache.iog.io"
        "https://iohk.cachix.org"
      ];
      trusted-public-keys = [
        "liqwid.cachix.org-1:NTIoFirJofiCSU9Khv0jSoxvYguYXesa7slQ0+f8r3M="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      ];
      trusted-users = [ "root" "sho" ];
    };

    distributedBuilds = true;

    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      keep-outputs = true
      keep-derivations = true
    '';
  };
}
