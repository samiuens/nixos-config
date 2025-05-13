{ hostname, ... }: 
  let name = "jellyseerr";
    domain = "https://${name}.${hostname}.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };