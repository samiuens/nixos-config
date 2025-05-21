{ username, ... }: {
  system.defaults = {
    finder = {
      AppleShowAllFiles = false;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      NewWindowTarget = "Other";
      NewWindowTargetPath = "file:///Users/${username}/Documents";
      ShowPathbar = true;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };
  };
}