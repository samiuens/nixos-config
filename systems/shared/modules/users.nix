{ vars, username, hostname, ... }: {
  users.users.${username} = {
    description = "${vars.fullName}";
    isNormalUser = true;
  };
}