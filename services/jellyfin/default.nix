{ hostname, ... }: 
  let name = "jellyfin";
    domain = "https://media.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };