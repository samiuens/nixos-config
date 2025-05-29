{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = "~/.ssh/github-auth_keychain";
        #identityFile = "~/.ssh/github-auth_backup";
        identityAgent = "none";
      };
      "srv-prod-1" = {
        hostname = "srv-prod-1.samiarda.com";
        user = "samiarda";
        identitiesOnly = true;
        identityFile = "~/.ssh/srv-prod-1_keychain";
        #identityFile = "~/.ssh/srv-prod-1_backup";
        identityAgent = "none";
      };
    };
  };
  #services.ssh-agent.enable = true;
}