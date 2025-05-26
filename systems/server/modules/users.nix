{ username, hostname, ...}: {
  users.users.${username} = {
    home = "/home/${username}";
    isNormalUser = true;
    extraGroups = [ "root" "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      ../../../secrets/public/${hostname}-keychain.pub
      ../../../secrets/public/${hostname}-backup.pub
    ];
  };
}