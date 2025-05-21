{ pkgs, lib, hostname, username, platform, system, vars, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = import ../home { inherit username system pkgs lib; };
  home-manager.backupFileExtension = "hm-backup";
  home-manager.extraSpecialArgs = {
    inherit hostname username platform system vars;
  };
}
