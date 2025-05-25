{ username, hostname, ...}: {
  users.users.${username} = {
    home = "/home/${username}";
    group = "${username}";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      ../../../secrets/public/${hostname}-keychain.pub
      ../../../secrets/public/${hostname}-backup.pub
    ];
  };
  users.groups = {
    "${username}" = {
      gid = 1000;
    };
  };
}