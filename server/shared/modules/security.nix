{ username, ... }: {
  security.sudo.extraRules = [
    { 
      users = [ ${username} ];
      commands = [
        { 
          command = "ALL" ;
          options= [ "NOPASSWD" ];
        }
      ];
    }
  ];
  networking.firewall.enable = true;
}