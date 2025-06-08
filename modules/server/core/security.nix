{ hostConfig, ... }: {
  security.sudo.enable = true;
  security.sudo.extraRules = [
    { 
      users = [ "${hostConfig.user.username}" ];
      commands = [
        { 
          command = "ALL" ;
          options= [ "NOPASSWD" ];
        }
      ];
    }
  ];
}