{ config, lib, pkgs, ... }:
{
  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
    enableOnBoot = false;
    liveRestore = false;
  };

  virtualisation.podman.enable = true;
  virtualisation.containers.registries.search = [ "docker.io"
}
