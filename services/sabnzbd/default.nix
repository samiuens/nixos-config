{ hostname, ... }: 
  let name = "sabnzbd";
    domain = "https://${name}.${hostname}.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };