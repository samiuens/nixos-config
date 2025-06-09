{ lib, ... }: {
  loadServerConfigServices = serverConfig: folderPath:
    let
      folderContents = builtins.readDir folderPath;
      contentNames = builtins.attrNames folderContents;

      allModulePaths = builtins.foldl' (acc: name:
        let
          type = builtins.getAttr name folderContents;
          fullPath = "${folderPath}/${name}";
          isNixFile = type == "regular" && lib.hasSuffix ".nix" name;
          isDirectory = type == "directory";
        in
        if isNixFile || isDirectory then
          acc ++ [ fullPath ]
        else
          acc
      ) [] contentNames;

      foundModuleNames = builtins.map (path:
        let
          baseName = builtins.baseNameOf path;
          isPathToNixFile = lib.hasSuffix ".nix" baseName;
        in
        if isPathToNixFile then
          lib.removeSuffix ".nix" baseName
        else
          baseName
      ) allModulePaths;

      checkedModuleImports = builtins.mapAttrs (moduleName: isEnabled:
        if isEnabled then
          let
            matchingPaths = builtins.filter
              (path:
                let
                  baseName = builtins.baseNameOf path;
                  nameWithoutSuffix = if lib.hasSuffix ".nix" baseName then lib.removeSuffix ".nix" baseName else baseName;
                in
                nameWithoutSuffix == moduleName
              )
              allModulePaths;

            modulePath = if matchingPaths != [] then builtins.head matchingPaths else null;
          in
          if modulePath != null then
            import modulePath
          else
            #lib.warn "WARN: The service '${moduleName}' is activated in the config, but the file or folder '${folderPath}/${moduleName}' (or '${folderPath}/${moduleName}.nix') doesnt exist!" {}
            {}
        else
          {}
      ) serverConfig;

      activeModuleImports = builtins.filter (moduleModule: moduleModule != { }) (builtins.attrValues checkedModuleImports);
    in
    activeModuleImports;
}