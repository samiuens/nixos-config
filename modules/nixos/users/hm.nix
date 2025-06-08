{ 
  pkgs,
  lib,
  myConfig,
  hostConfig,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;k.nix { inherit pkgs lib myConfig hostConfig; });
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {

    users.${hostConfig.user.username} = import ../../home { inherit pkgs lib myConfig hostConfig; };
    users.${hostConfig.workUser.username} = lib.mkIf hostConfig.workUser.enabled (import ../../home/work.nix { inherit pkgs lib myConfig hostConfig; });
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit myConfig hostConfig;
    };
  };
}
