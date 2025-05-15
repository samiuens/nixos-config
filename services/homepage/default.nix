{ config, pkgs, hostname, baseDomain, username, ... }: 
  let 
    name = "homepage";
    image = "ghcr.io/gethomepage/homepage:latest";
    domain = "home.${hostname}.${baseDomain}";
    
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
      ports = [ "80:80" "443:443" ];
      volumes = [
        "${homepageSettings}:/app/config/settings.yaml"
        "/var/run/docker.sock:/var/run/docker.sock:ro"
      ];
      environment = {
        HOMEPAGE_ALLOWED_HOSTS = "${domain}";
      };
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.${name}.rule" = "Host(`${domain}`)";
        "traefik.http.routers.${name}.entrypoints" = "https";
        "traefik.http.routers.${name}.tls" = "true";
      };
      extraOptions = [ "--network=${hostname}" ];
    };
  }