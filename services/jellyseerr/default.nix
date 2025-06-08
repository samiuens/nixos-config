{ myConfig, hostConfig, ... }:
  let 
    name = "jellyseerr";
    image = "fallenbagel/jellyseerr:latest";
    domain = "jellyseerr.${hostConfig.hostname}.${myConfig.domain}";
    volumePath = "/srv/${name}";
  in {
  # Use Docker as the container backend
  virtualisation.oci-containers.backend = "docker";
  # Define the container
  virtualisation.oci-containers.containers."${name}" = {
    image = "${image}";
    environment = {
      TZ = "${myConfig.timezone}";
    };
    volumes = [
      "${volumePath}/config:/app/config"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.${name}.rule" = "Host(`${domain}`)";
      "traefik.http.routers.${name}.entrypoints" = "https";
      "traefik.http.routers.${name}.tls" = "true";
      "traefik.http.services.${name}.loadbalancer.server.port" = "5055";
    };
    extraOptions = [ "--network=${hostConfig.hostname}" ];
  };
}