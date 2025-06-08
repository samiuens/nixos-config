{ hostname, ... }: 
  let 
    name = "paperless";
    image = "ghcr.io/gethomepage/homepage:latest";
    domain = "paperless.${hostname}.samiarda.com";
    port = 3000;
  in {
    virtualisation.oci-containers = {
      backend = "podman";
      containers.${name} = {
        image = "${image}";
        volumes = [ "${name}:/app/config" ];
        environment.HOMEPAGE_ALLOWED_HOSTS = "${domain}";
      };
    };
  };