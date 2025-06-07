{
  loadHostConfigApplications = hostConfig: folderPath:
    let
      appModulePaths = lib.filter
        (path:
          let
            baseName = builtins.baseNameOf path;
          in
          lib.hasSuffix ".nix" baseName
        )
        (builtins.map (name: "${folderPath}/${name}") (builtins.attrNames (builtins.readDir folderPath)));

      activeAppImports = lib.filter (appModule: appModule != { }) (
        lib.map (appPath:
          let
            appName = lib.removeSuffix ".nix" (builtins.baseNameOf appPath);
          in
          if lib.getAttrFromPath [ appName ] hostConfig.applications or false
          then appPath
          else { }
        ) appModulePaths
      );
    in
    activeAppImports;
}
