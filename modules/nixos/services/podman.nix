{ hostConfig, ... }: {
  virtualisation.podman.enable = true;
  users.users."${hostConfig.user.username}".extraGroups = [ "podman" ];
}