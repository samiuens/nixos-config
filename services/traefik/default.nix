{ config, hostname, baseDomain, ... }: 
  let 
    name = "traefik";
    image = "traefik:v3.4";
    domain = "traefik.${hostname}.${baseDomain}";
  in {
    # Allow HTTP (80), HTTPS (443), and Traefik Dashboard (8080)
    networking.firewall.allowedTCPPorts = [ 80 443 8080 ];

    # Use Podman as the container backend
    virtualisation.oci-containers.backend = "podman";

    # Define the container
    virtualisation.oci-containers.containers."${name}" = {
      image = "${image}";
      ports = [ "80:80" "443:443" "8080:8080" ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock:ro"
        "/etc/traefik:/etc/traefik"
      ];
      environment = {
        CF_API_KEY = ${config.sops.secrets.CLOUDFLARE_API_KEY};
        TRAEFIK_DASHBOARD_CREDENTIALS = "${config.sops.secrets.TRAEFIK_DASHBOARD_CREDENTIALS}";
      };
      binds = [
        "${./config/traefik.yaml}:/etc/traefik/traefik.yaml"
      ];
      labels = [
        "traefik.enable=true"
        "traefik.http.routers.traefik.entrypoints=http"
        "traefik.http.routers.traefik.rule=Host(`${domain}`)"
        "traefik.http.middlewares.traefik-auth.basicauth.users=${config.sops.secrets.TRAEFIK_DASHBOARD_CREDENTIALS}"
        "traefik.http.middlewares.traefik-https-redirect.redirectscheme.scheme=https"
        "traefik.http.middlewares.sslheader.headers.customrequestheaders.X-Forwarded-Proto=https"
        "traefik.http.routers.traefik.middlewares=traefik-https-redirect"
        "traefik.http.routers.traefik-secure.entrypoints=https"
        "traefik.http.routers.traefik-secure.rule=Host(`${domain}`)"
        "traefik.http.routers.traefik-secure.middlewares=traefik-auth"
        "traefik.http.routers.traefik-secure.tls=true"
        "traefik.http.routers.traefik-secure.tls.certresolver=cloudflare"
        "traefik.http.routers.traefik-secure.tls.domains[0].main=${hostname}.${baseDomain}"
        "traefik.http.routers.traefik-secure.tls.domains[0].sans=*.${hostname}.${baseDomain}"
        "traefik.http.routers.traefik-secure.service=api@internal"
      ];
      extraOptions = [ "--network=${hostname}" ];
    };
  };