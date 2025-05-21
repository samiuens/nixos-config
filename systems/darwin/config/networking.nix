{ hostname, ... }: {
  networking = {
    computerName = "${hostname}";
    hostName = "${hostname}";
    localHostName = "${hostname}";
  };
  system.defaults.smb = {
    NetBIOSName = "${hostname}";
  };
}
