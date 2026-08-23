{ inputs, ... }: {
  den.aspects.noctalia-shell = {
    homeManager = { lib, ... }: {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        systemd.enable = lib.mkDefault true;
        settings = lib.mapAttrsRecursive (name: value: lib.mkDefault value) (
          fromTOML (builtins.readFile ./noctalia.toml)
        );
      };
    };
  };
}
