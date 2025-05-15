{ hostname, ... }: 
  let name = "netdata";
  in {
    # Allow Netdata (19999)
    networking.firewall.allowedTCPPorts = [ 19999 ];
    # Defining secrets
    sops.secrets.netdata_claim_token = {};
    # Defining service
    services.${name} = {
      enable = true;
      port = 19999;
      claimTokenFile = "${config.sops.secrets.netdata_claim_token.path}";
    };
  };