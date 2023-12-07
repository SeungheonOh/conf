{ config, lib, pkgs, ... }:
# let
#   secrets = import ../secrets.nix;
# in
{
  # users.users.dynamicdns = {
  #    isSystemUser = true;
  #    group = "dynamicdns";
  # };
  # users.groups.dynamicdns = {};
  # systemd.services.dynamic-dns-updater = {
  #     serviceConfig.User = "dynamicdns";
  #     path = [
  #       pkgs.curl
  #     ];
  #     script = "curl https://freedns.afraid.org/dynamic/update.php?${secrets.freedns}";
  #     startAt = "hourly";
  # };
  # systemd.timers.dynamic-dns-updater.timerConfig.RandomizedDelaySec = "15m";
}
