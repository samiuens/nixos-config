{ config, pkgs, ... }: 
  let name = "netdata";
  in {
    # Defining secrets
    sops.secrets."netdata/claim-token" = {};
    # Defining service
    services.${name} = {
      enable = true;
      # Using the netdata package with cloud ui enabled
      package = pkgs.netdata.override { withCloud = true; };
      config.global = {
        "memory mode" = "ram";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
      claimTokenFile = config.sops.secrets."netdata/claim-token".path;
    };
  }