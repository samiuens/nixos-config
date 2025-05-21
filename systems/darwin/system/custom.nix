{
  system.defaults = {
    CustomUserPreferences = {
      "NSGlobalDomain" = {
        "AppleReduceDesktopTinting" = 1;
      };
      "com.apple.finder" = {
        "FinderSpawnTab" = false;
      };
      "com.apple.desktopservices" = {
        "DSDontWriteNetworkStores" = true;
        "DSDontWriteUSBStores" = true;
      };
    };

    CustomSystemPreferences = {
      "com.apple.ImageCapture" = { "disableHotPlug" = true; };
    };
  };
}