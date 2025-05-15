{ config, pkgs, hostname, baseDomain, username, ... }: 
  let 
    name = "traefik";
    image = "traefik:latest";
    domain = "traefik.${hostname}.${baseDomain}";
    
    # Container files
    traefikConfig = pkgs.writeTextFile {
      name = "treafik.yaml";
      text = builtins.readFile ./traefik.yaml;
    };
  in {
    # Allow DNS (53), HTTP (80), HTTPS (443), and Traefik Dashboard (8080)
    networking.firewall.allowedTCPPorts = [ 53 80 443 8080 ];

    # Defining secrets
    sops.secrets = { 
      traefik-env = {};
    };

    # Use Docker as the container backend
    virtualisation.oci-containers.backend = "docker";

    # Define the container
    virtualisation.oci-containers.containers."${name}" = {
      image = "${image}";
      ports = [ "80:80" "443:443" "8080:8080" ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock:ro"
        "${traefikConfig}:/etc/traefik/traefik.yaml:ro"
      ];
      environmentFiles = [
        "${config.sops.secrets.traefik-env.path}"
      ];
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.traefik.entrypoints" = "http";
        "traefik.http.routers.traefik.rule" = "Host(`${domain}`)";
        #"traefik.http.middlewares.traefik-auth.basicauth.users" = "${config.sops.secrets.traefik_dashboard_credentials.path}";
        "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme" = "https";
        "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto" = "https";
        "traefik.http.routers.traefik.middlewares" = "traefik-https-redirect";
        "traefik.http.routers.traefik-secure.entrypoints" = "https";
        "traefik.http.routers.traefik-secure.rule" = "Host(`${domain}`)";
        #"traefik.http.routers.traefik-secure.middlewares" = "traefik-auth";
        "traefik.http.routers.traefik-secure.tls" = "true";
        "traefik.http.routers.traefik-secure.tls.certresolver" = "cloudflare";
        "traefik.http.routers.traefik-secure.tls.domains[0].main" = "${hostname}.${baseDomain}";
        "traefik.http.routers.traefik-secure.tls.domains[0].sans" = "*.${hostname}.${baseDomain}";
        "traefik.http.routers.traefik-secure.service" = "api@internal";
      };
      extraOptions = [ "--network=${hostname}" ];
    };
  }