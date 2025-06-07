{ hostConfig, ... }: {
  networking = {
    hostName = hostConfig.hostname;
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
