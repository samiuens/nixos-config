{ hostname, ... }: 
  let name = "rustdesk-server";
    domain = "https://rustdesk.${hostname}.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };