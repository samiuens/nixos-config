{ vars, hostname, username, ... }:
  let 
    name = "jellyfin";
    image = "jellyfin/jellyfin";
    domain = "jellyfin.${hostname}.${vars.domain}";
    volumePath = "/srv/${name}";
  in {
  # Use Docker as the container backend
  virtualisation.oci-containers.backend = "docker";
  # Define the container
  virtualisation.oci-containers.containers."${name}" = {
    image = "${image}";
    environment = {
      JELLYFIN_PublishedServerUrl = "${domain}";
    };
    volumes = [
      "${volumePath}/config:/config"
      "${volumePath}/cache:/cache"
      "/mnt/media/media:/media"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.${name}.rule" = "Host(`${domain}`)";
      "traefik.http.routers.${name}.entrypoints" = "https";
      "traefik.http.routers.${name}.tls" = "true";
      "traefik.http.services.${name}.loadbalancer.server.port" = "8096";
    };
    extraOptions = [ "--network=${hostname}" ];
  };
}