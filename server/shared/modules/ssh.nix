{ hostname, username, pkgs, ... }: {
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

  services.fail2ban = {
    enable = true;
    filter = "sshd";
    logPath = "/var/log/auth.log";
    # Ban IP after 5 failures
    maxretry = 5;
    # Ban IPs for one day on the first ban
    bantime = "24h"; 
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };

  environment.etc = {
    # Defines a filter that detects SSH brute force attacks
    "fail2ban/filter.d/ssh-key.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      failregex = sshd(?:\[\d+\])?: Connection closed by <HOST> .*preauth.*\s*$
    '');
  };
}