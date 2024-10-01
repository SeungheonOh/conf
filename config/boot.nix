{ config, lib, pkgs, ... }:
{
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    tmp.cleanOnBoot = true;
  };
}
