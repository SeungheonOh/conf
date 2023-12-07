{ pkgs, ... }:
{
  users.extraGroups.plugdev = { };
  users.extraUsers.sho.extraGroups = [ "plugdev" ];
  services.udev.packages = [ pkgs.openocd ];
}
