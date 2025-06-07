{ hostname, ... }: {
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
  ];

  # Mount external hard drive for data storage
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/78f433f8-4560-428f-bd3f-df9872a53706";
    fsType = "ext4";
    options = [
      "defaults"
      "users"
      "nofail"
    ];
  };
  system.stateVersion = "24.11";
}