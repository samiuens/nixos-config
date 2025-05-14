{ username, hostname, ... }: {
  users.users.${username} = {
    home = "/home/${username}";
    description = "Sami Arda Ünsay";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      "../../../secrets/public/${hostname}-keychain.pub"
      "../../../secrets/public/${hostname}-backup.pub"
    ];
  };
}