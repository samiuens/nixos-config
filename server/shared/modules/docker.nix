{ hostname, pkgs, ... }: {
  virtualisation.docker.enable = true;

  # Create docker network if it doesn't exist
  systemd.services."docker-${hostname}_network" = {
    description = "Create docker network for ${hostname}.";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    conditionPathExists = "!/var/run/docker/netns/${hostname}";

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.docker}/bin/docker network create --driver bridge ${hostname}";
      ExecStop = "${pkgs.docker}/bin/docker network rm ${hostname}";
    };
  };
}