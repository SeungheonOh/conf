{ config, lib, pkgs, ... }:
{
  # enable powertop auto tuning on startup.
  powerManagement.powertop.enable = true;

  # Better scheduling for CPU cycles - thanks System76!!!
  services.system76-scheduler.settings.cfsProfiles.enable = true;
  # Enable thermald, the temperature management daemon. (only necessary if on Intel CPUs)
  services.thermald.enable = true;
  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = false;
  # Enable TLP (better than gnomes internal power manager)
  services.tlp = {
    enable = true;
    settings = { # sudo tlp-stat or tlp-stat -s or sudo tlp-stat -p
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      START_CHARGE_THRESH_BAT1 = 80;
      STOP_CHARGE_THRESH_BAT1 = 85;
    };
  };
  services = {
    logind = {
      lidSwitch = "hibernate";
      extraConfig = ''
        HandlePowerKey=hibernate
      '';
    };
  };
}
