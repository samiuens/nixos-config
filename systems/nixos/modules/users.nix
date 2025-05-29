{ vars, username, hostname, work, lib, ...}: {
  users.users.${username} = {
    home = "/home/${username}";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  users.users.${vars.work.username} = lib.mkIf work {
    home = "/home/${vars.work.username}";
    isNormalUser = true;
  };
}