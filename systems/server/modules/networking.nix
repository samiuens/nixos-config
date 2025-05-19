{ hostname, ... }: {
  networking = {
    hostName = hostname;
    firewall.enable = true;
  };
}
