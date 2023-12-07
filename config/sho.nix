{ config, lib, pkgs, ... }:
{
  users.users.sho = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" "video" "dialout" "tty" "docker" "plugdev" "lidarr" ];
  };
}
