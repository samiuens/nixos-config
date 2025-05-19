{ config, pkgs, vars, hostname, username, ... }: 
  let 
    name = "homepage";
    image = "ghcr.io/gethomepage/homepage:latest";
    domain = "home.${hostname}.${vars.domain}";
    
    # Container files
    homepageSettings = pkgs.writeTextFile {
      name = "settings.yaml";
      text = builtins.readFile ./settings.yaml;
    };
  in {
    # Use Docker as the container backend
    virtualisation.oci-containers.backend = "docker";

    # Define the container
    virtualisation.oci-containers.containers."${name}" = {
      image = "${image}";
      volumes = [
        "${homepageSettings}:/app/config/settings.yaml"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
      environment = {
        #HOMEPAGE_ALLOWED_HOSTS = "${domain}";
      };
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.${name}.rule" = "Host(`${domain}`)";
        "traefik.http.routers.${name}.entrypoints" = "https";
        "traefik.http.routers.${name}.tls" = "true";
        "traefik.http.services.${name}.loadbalancer.server.port" = "3000";
      };
      extraOptions = [ "--network=${hostname}" ];
    };
  }