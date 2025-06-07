{ lib, ... }: {
  loadHostConfigModules = hostConfig: folderPath:
    let
      modulePaths = lib.filter
        (path:
          let
            baseName = builtins.baseNameOf path;
          in
          lib.hasSuffix ".nix" baseName
        )
        (builtins.map (name: "${folderPath}/${name}") (builtins.attrNames (builtins.readDir folderPath)));

      foundModuleNames = lib.map (path: lib.removeSuffix ".nix" (builtins.baseNameOf path)) modulePaths;

      checkedModuleImports = lib.mapAttrs (moduleName: isEnabled:
        if isEnabled then
          if lib.elem moduleName foundModuleNames
          then (
            let
              matchingPaths = lib.filter
                (path: lib.removeSuffix ".nix" (builtins.baseNameOf path) == moduleName)
                modulePaths;
              modulePath = builtins.head matchingPaths;
            in
            import modulePath
          )
          else {}
          #else lib.warn "WARN: The module '${moduleName}' is activated in the config, but the file '${folderPath}/${moduleName}.nix' doesnt exist!" { }
        else
          { }
      ) hostConfig;

      activeModuleImports = lib.filter (moduleModule: moduleModule != { }) (lib.attrValues checkedModuleImports);
    in
    activeModuleImports;
}