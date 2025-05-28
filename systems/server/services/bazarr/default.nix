{ vars, hostname, username, ... }:
  let 
    name = "bazarr";
    image = "lscr.io/linuxserver/bazarr:latest";
    domain = "bazarr.${hostname}.${vars.domain}";
    volumePath = "/srv/${name}";
  in {
  # Use Docker as the container backend
  virtualisation.oci-containers.backend = "docker";
  # Define the container
  virtualisation.oci-containers.containers."${name}" = {
    image = "${image}";
    environment = {
      TZ = "${vars.server.timezone}";
      PUID = "0";
      PGID = "0";
    };
    volumes = [
      "${volumePath}/config:/config"
      "/mnt/media/media/movies:/movies"
      "/mnt/media/media/series:/series"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.${name}.rule" = "Host(`${domain}`)";
      "traefik.http.routers.${name}.entrypoints" = "https";
      "traefik.http.routers.${name}.tls" = "true";
      "traefik.http.services.${name}.loadbalancer.server.port" = "6767";
    };
    extraOptions = [ "--network=${hostname}" ];
  };
}