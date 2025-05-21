{
  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults = {
    SoftwareUpdate = { AutomaticallyInstallMacOSUpdates = true; };
    alf = {
      globalstate = 1;
      stealthenabled = 1;
    };
    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };
  };
}
