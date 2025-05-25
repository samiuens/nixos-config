{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "srv-prod-1" = {
        hostname = "srv-prod-1.samiarda.com";
        user = "samiarda";
        identityFile = "~/.ssh/srv-prod-1-keychain";
        #identityFile = "~/.ssh/srv-prod-1-backup";
      };
    };
  };
}