{ username, hostname, vars, work, lib, ...}: {
  users.users.${username} = {
    home = "/Users/${username}";
    isHidden = false;
  };

  users.users.${vars.work.username} = lib.mkIf work {
    home = "/Users/${vars.work.username}";
    isHidden = false;
  };

  system.primaryUser = "${username}";
}