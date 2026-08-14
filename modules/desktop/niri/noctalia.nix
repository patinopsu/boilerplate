{ inputs, self, ... }: {
  den.aspects.noctalia-shell = {
    nixos = { user, ... }: {
      preservation.preserveAt."/persistent".users.${user.name} = {
        directories = [
          ".config/noctalia/"
        ];
      };
    };
    homeManager = { lib, ... }: {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        systemd.enable = lib.mkDefault true;
        settings = lib.mapAttrsRecursive (name: value: lib.mkDefault value) (
          builtins.fromTOML (builtins.readFile ./noctalia.toml)
        );
      };
    };
  };
}
