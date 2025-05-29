{ vars, ... }:
  let username = vars.workProfile.username;
  in {
    users.users.${username} = {
      home = "/home/${username}";
      isNormalUser = true;
    };
  }