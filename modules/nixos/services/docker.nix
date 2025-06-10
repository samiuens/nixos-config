{ hostConfig, ... }: {
  virtualisation.docker.enable = true;
  users.users."${hostConfig.user.username}".extraGroups = [ "docker" ];
}