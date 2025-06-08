{ hostConfig, ... }: {
  networking = {
    computerName = "${hostConfig.hostname}";
    hostName = "${hostConfig.hostname}";
    localHostName = "${hostConfig.hostname}";
  };
  system.defaults.smb = {
    NetBIOSName = "${hostConfig.hostname}";
  };
}
