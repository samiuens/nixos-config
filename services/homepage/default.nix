{ hostname, ... }: 
  let name = "homepage";
    domain = "https://dashboard.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };