{ 
  pkgs,
  lib,
  config,
  hostConfig,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${hostConfig.user.username} = import ../../home { inherit pkgs lib; };
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit config hostConfig;
    };
  };
}
