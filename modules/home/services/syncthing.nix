{ config, hostConfig, ... }: {
  services.syncthing =
    let syncthingOptions = {
      listenAddresses = [ "tcp://${hostConfig.hostname}:22000" ];
      urAccepted = -1;
    }; in {
    enable = true;
    settings = {
      devices = {
        smi-nixos = {
          addresses = [ "tcp://smi-nixos:22000" ];
          id = "Y3IRSSF-JHQDFXM-C4PY2WM-OPGOUG6-7HY2RLX-IASAOXA-PXNL4KR-IQZ4NQF";
        };
        smi-mac = {
          addresses = [ "tcp://smi-mac:22000" ];
          id = "XGSY7XN-NOTAQ5S-OVKCOPD-YCJY5LH-3SXLCMW-7RUA5EL-DGPUPLT-OAMCXQM";
        };
        smi-phone = {
          addresses = [ "tcp://smi-phone:22000" ];
          id = "HXPIM4J-SISZQW3-5QVDBDM-23U3FTD-MBACL4X-NEKXWRM-XAN6QVJ-RQXFCQA";
        };
      };
      folders = {
        "Sami Arda's Vault" = {
          id = "obsidian-vault";
          label = "Sami Arda's Vault";
          path = "~/Sync/Sami Arda's Vault";
          devices = [ "smi-nixos" "smi-mac" "smi-phone" ];
        };
        "secure-enclave" = {
          id = "secure-enclave";
          label = "secure-enclave";
          path = "~/Sync/secure-enclave";
          devices = [ "smi-nixos" "smi-mac" ];
        };
      };
      options = syncthingOptions;
    };
  };
}