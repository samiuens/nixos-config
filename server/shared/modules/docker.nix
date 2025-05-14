{ hostname, pkgs, ... }: {
  virtualisation.docker.enable = true;

  # Create docker network
  systemd.services."docker-${hostname}_network" = {
    description = "Erstelle das Docker-Netzwerk für ${hostname}.";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.docker}/bin/docker network create --driver bridge ${hostname}";
      #ExecStop = "${pkgs.docker}/bin/docker network rm ${hostname}";
    };
  };
}