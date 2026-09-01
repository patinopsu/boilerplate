{ inputs, ... }: {
  den.aspects.noctalia-shell = {
    nixos = {
      nix.settings = {
        substituters = [ "https://noctalia.cachix.org" ];
        trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };
    };

    homeManager = { lib, ... }: {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        systemd.enable = true;
        settings = lib.mapAttrsRecursive (name: value: lib.mkDefault value) (
          fromTOML (builtins.readFile ./noctalia.toml)
        );
      };
    };
  };
}
