{ lib, ... }: {
  loadHostConfigModules = hostConfig: folderPath: configType:
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

      getModulesForType = configType:
        builtins.mapAttrs (appName: appConfig:
          if builtins.isAttrs appConfig && builtins.hasAttr configType appConfig then
            let
              isEnabled = builtins.getAttr configType appConfig;
            in
            if isEnabled == true then
              let
                matchingPaths = builtins.filter
                  (path:
                    let
                      baseName = builtins.baseNameOf path;
                      nameWithoutSuffix = if lib.hasSuffix ".nix" baseName then lib.removeSuffix ".nix" baseName else baseName;
                    in
                    nameWithoutSuffix == appName
                  )
                  allModulePaths;

                modulePath = if matchingPaths != [] then builtins.head matchingPaths else null;
              in
              if modulePath != null then
                import modulePath
              else
                {}
            else
              {}
          else
            {}
        ) hostConfig;

      activeModuleImports = builtins.filter (moduleModule: moduleModule != { }) (builtins.attrValues (getModulesForType configType));
    in
    activeModuleImports;
}