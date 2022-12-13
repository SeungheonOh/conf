{ config, pkgs, ... }: {
  home = {
    file = {
      ".agda/standard-library.agda-lib".text = ''
        name: standard-library
        include: src
      '';
      ".agda/defaults".text = ''
        standard-library
      '';
    };

    packages = with pkgs; [
      (agda.withPackages (p: [ p.standard-library ]))
      emacsPackages.agda2-mode
    ];
  };
}
