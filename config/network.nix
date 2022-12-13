{ config, lib, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
    };
    dhcpcd.extraConfig = "noarp";
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
