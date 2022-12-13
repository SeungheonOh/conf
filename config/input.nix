{ config, lib, pkgs, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "kime";
      kime.config = {
        indicator.icon_color = "White";
      };
    };
  };
}
