{ 
  pkgs,
  lib,
  myConfig,
  hostConfig,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${hostConfig.user.username} = import ../../home { inherit pkgs lib myConfig hostConfig; };
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit myConfig hostConfig;
    };
  };
}
