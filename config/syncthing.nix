{config, lib, pkgs, ...}:
{
  services = {
    syncthing = {
      enable = true;
      user = "Seungheon Oh";
      dataDir = "/home/sho/Logseq";
      configDir = "/home/sho/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      devices = {
      };
      folders = {
        "Logseq" = {
          path = "home/sho/Logseq";
        };
      };
    };
  };
}
