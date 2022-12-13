{ config, pkgs, ... }: {
  home = {
    file = {
      ".ghci".text = ''
        :seti -XOverloadedStrings -XTypeApplications -XOverloadedLists -XNoStarIsType -XDataKinds -XRankNTypes
        :set +m
        :set +s
        :set +t

        :set prompt "λ "
      '';
    };
    packages = with pkgs; [
      # haskell.packages.ghc925.ghc
      # haskell.packages.ghc925.QuickCheck

      # haskellPackages.stack
      # haskellPackages.cabal2nix
      # haskellPackages.cabal-install
      # haskellPackages.hoogle
      # haskellPackages.implicit-hie
      # haskellPackages.nix-tree
      # haskellPackages.ghcid

      ripgrep
      git
    ];
  };
}
