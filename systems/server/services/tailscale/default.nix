{ config, ... }: 
  let name = "tailscale";
  in {
    # Defining secrets
    sops.secrets."tailscale/auth-key" = {};

    services.${name} = {
      enable = true;
      authKeyFile = config.sops.secrets."tailscale/auth-key".path;
      useRoutingFeatures = "client";
    };
  }