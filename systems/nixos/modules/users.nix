{ username, hostname, ...}: {
  users.users.${username} = {
    home = "/home/${username}";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}