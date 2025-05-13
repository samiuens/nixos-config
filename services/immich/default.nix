{ hostname, ... }: 
  let name = "immich";
    domain = "https://${name}.${hostname}.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };