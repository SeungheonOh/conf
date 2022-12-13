{ config, lib, pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    fonts = with pkgs; [
      victor-mono
      unifont
      iosevka
      mononoki

      nanum-gothic-coding
      noto-fonts-cjk

      noto-fonts-emoji
    ];
  };
}
