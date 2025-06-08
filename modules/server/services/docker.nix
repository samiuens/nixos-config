{ pkgs, hostConfig, ... }: {
  virtualisation.docker.enable = true;

  # Create docker network if it doesn't exist
  /*systemd.services."docker-${hostConfig.hostname}_network" = {
    description = "Create docker network for ${hostConfig.hostname}.";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.docker}/bin/docker network create --driver bridge ${hostConfig.hostname}";
      ExecStop = "${pkgs.docker}/bin/docker network rm ${hostConfig.hostname}";
    };
  };*/
  users.users.${hostConfig.user.username}.extraGroups = [ "docker" ];
}