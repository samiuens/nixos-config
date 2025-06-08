{ hostname, ... }: 
  let name = "ntfy-sh";
    domain = "https://${name}.${hostname}.samiarda.com";
  in {
    services.${name} = {
      enable = true;
    };
  };