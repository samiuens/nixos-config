{ hostname, ... }: 
  let name = "traefik";
    domain = "https://${name}.${hostname}.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };