{ myConfig, hostConfig, ... }:
  let 
    name = "radarr";
    image = "lscr.io/linuxserver/radarr:latest";
    domain = "radarr.${hostConfig.hostname}.${myConfig.domain}";
    volumePath = "/srv/${name}";
  in {
  # Use Docker as the container backend
  virtualisation.oci-containers.backend = "docker";
  # Define the container
  virtualisation.oci-containers.containers."${name}" = {
    image = "${image}";
    environment = {
      TZ = "${myConfig.timezone}";
      PUID = "0";
      PGID = "0";
    };
    volumes = [
      "${volumePath}/data:/config"
      "/mnt/data:/data"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.${name}.rule" = "Host(`${domain}`)";
      "traefik.http.routers.${name}.entrypoints" = "https";
      "traefik.http.routers.${name}.tls" = "true";
      "traefik.http.services.${name}.loadbalancer.server.port" = "7878";
    };
    extraOptions = [ "--network=${hostConfig.hostname}" ];
  };
}