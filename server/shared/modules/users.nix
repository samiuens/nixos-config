{ username, hostname, ... }: {
  users.users.${username} = {
    home = "/home/${username}";
    description = "Sami Arda Ünsay";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      "../../../secrets/${hostname}-keychain.pub"
      "../../../secrets/${hostname}-backup.pub"
    ];
  };
}