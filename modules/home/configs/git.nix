{ hostConfig, ... }: {
  programs.git = {
    enable = true;
    userName  = "${hostConfig.user.name}";
    userEmail = "192653549+samiuens@users.noreply.github.com";
  };
}