{ vars, hostname, username, ... }:
  let 
    name = "sabnzbd";
    image = "lscr.io/linuxserver/sabnzbd:latest";
    domain = "sabnzbd.${hostname}.${vars.domain}";
    volumePath = "/srv/${name}";
  in {
  #imports = [ ../../utils/copy-file.nix ];
  # Configuration files
  /*services.copyFile.sabnzbdConfig = {
    source = builtins.toFile "sabnzbd.ini" (builtins.readFile ./config/sabnzbd.ini);
    destination = "${volumePath}/config/sabnzbd.ini";
    before = [ "docker-${name}.service" ];
  };*/

  # Use Docker as the container backend
  virtualisation.oci-containers.backend = "docker";
  # Define the container
  virtualisation.oci-containers.containers."${name}" = {
    image = "${image}";
    environment = {
      TZ = "${vars.server.timezone}";
    };
    volumes = [
      "${volumePath}/config:/config"
      "${volumePath}/downloads/incomplete:/incomplete-downloads"
      "${volumePath}/downloads/complete:/downloads"
      "/mnt/media:/mnt/media"
    ];
    labels = {
      "traefik.enable" = "true";
      "traefik.http.routers.${name}.rule" = "Host(`${domain}`)";
      "traefik.http.routers.${name}.entrypoints" = "https";
      "traefik.http.routers.${name}.tls" = "true";
      "traefik.http.services.${name}.loadbalancer.server.port" = "8080";
    };
    extraOptions = [ "--network=${hostname}" ];
  };
}