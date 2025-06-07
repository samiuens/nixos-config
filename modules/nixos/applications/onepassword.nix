{ hostConfig, ... }: {
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "${hostConfig.user.username}" ];
  };
}