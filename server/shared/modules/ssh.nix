{ hostname, username, ... }: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${username}" ];
      PubkeyAuthentication = true;
      PermitRootLogin = "no";
    };
  };
}