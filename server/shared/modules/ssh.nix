{ hostname, username, ... }: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ ${username} ];
      PubkeyAuthentication = true;
      PermitRootLogin = "no";
    };
  };
}