{ lib, ... }:

{
  loadHostConfigApplications = applicationConfig: folderPath:
    let
      appModulePaths = lib.filter
        (path:
          let
            baseName = builtins.baseNameOf path;
          in
          lib.hasSuffix ".nix" baseName
        )
        (builtins.map (name: "${folderPath}/${name}") (builtins.attrNames (builtins.readDir folderPath)));

      foundAppNames = lib.map (path: lib.removeSuffix ".nix" (builtins.baseNameOf path)) appModulePaths;

      checkedAppImports = lib.mapAttrs (appName: isEnabled:
        if isEnabled then
          if lib.elem appName foundAppNames
          then (
            lib.findSingle
              (path: lib.removeSuffix ".nix" (builtins.baseNameOf path) == appName)
              appModulePaths
          )
          else lib.warn "WARN: The application '${appName}' is activated in your config, but the file '${folderPath}/${appName}.nix' doesnt exist!" { }
        else
          { }
      ) applicationConfig;

      activeAppImports = lib.filter (appModule: appModule != { }) (lib.attrValues checkedAppImports);
    in
    activeAppImports;
}