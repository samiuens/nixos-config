{ username, hostname, ... }: {
  users.users.${username} = {
    home = "/home/${username}";
    description = "Sami Arda Ünsay";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      ../../../secrets/public/${hostname}-keychain.pub
      ../../../secrets/public/${hostname}-backup.pub
    ];
    hashedPassword = "$6$gsjBDZd8jmXtEZHv$Eta7mLPSvaoOTXUIAuT68OFOevXQUqOjE3M4x2zOHrk9AfPifhJ68u//sgUAtYjTE1Vhe5ZZon.647xss.Rrq.";
  };
}