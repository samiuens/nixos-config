{ pkgs, lib, hostname, username, platform, system, vars, work, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = import ../home { inherit username system pkgs lib; };
  home-manager.users.${vars.work.username} = lib.mkIf work (import ../home { inherit username system pkgs lib; });
  home-manager.backupFileExtension = "hm-backup";
  home-manager.extraSpecialArgs = {
    inherit hostname username platform system vars;
  };
}
