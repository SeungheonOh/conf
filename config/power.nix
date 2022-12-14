{ config, lib, pkgs, ... }:
{
  powerManagement.enable = true;

  services = {
    power-profiles-daemon.enable = false;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
    upower.enable = true;

    acpid.enable = true;

    logind = {
      lidSwitch = "hibernate";
    };
  };
}
