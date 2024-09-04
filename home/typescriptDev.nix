{ config, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      nodejs
      typescript
      nodePackages.typescript-language-server
    ];
  };
}
