{
  nix = {
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
  };
}
