{ username, hostname, ...}: {
  users.users.${username} = {
    home = "/Users/${username}";
    isHidden = false;
  };
  system.primaryUser = "${username}";
}