{ username, hostname, ...}: {
  users.users.${username} = {
    home = "/Users/${username}";
    isHidden = false;
  };
}