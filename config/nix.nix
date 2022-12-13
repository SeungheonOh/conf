{ config, lib, pkgs, ... }:
{
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
        "https://cache.iog.io"
        "https://iohk.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
      ];
    };

    distributedBuilds = true;

    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      keep-outputs = true
      keep-derivations = true
    '';
  };
}
