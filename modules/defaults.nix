{ self, lib, inputs, ... }: {
  imports = [
    inputs.den.flakeModules.dendritic
    inputs.flake-file.flakeModules.default
  ];

  den.default = {
    nixos = {
      system.stateVersion = "26.05";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup-${toString self.lastModified}";
    };

    homeManager = {
      home.stateVersion = "26.05";
    };
  };
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
