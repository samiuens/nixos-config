{ hostname, baseDomain, ... }: 
  let 
    name = "homepage-dashboard";
    domain = "home.${baseDomain}";
  in {
    services.${name} = {
      enable = true;
      domain = domain;
      openFirewall = false;
    };
  };