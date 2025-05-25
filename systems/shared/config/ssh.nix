{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "srv-prod-1" = {
        hostname = "srv-prod-1.samiarda.com";
        user = "samiarda";
        identitiesOnly = true;
        identityFile = "~/.ssh/srv-prod-1-keychain";
        #identityFile = "~/.ssh/srv-prod-1-backup";
        identityAgent = "none";
      };
    };
  };
  #services.ssh-agent.enable = true;
}