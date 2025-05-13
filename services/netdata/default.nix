{ hostname, ... }: 
  let name = "netdata";
    domain = "https://${name}.${hostname}.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };