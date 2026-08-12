{ inputs, self, ... }: {
  den.aspects.noctalia-shell = {
    homeManager = { lib, ... }: let
      inherit (lib) mapAttrs;

      mkDefaultsRecursive = v:
        if builtins.isAttrs v then
          mapAttrs (_: mkDefaultsRecursive) v
        else
          lib.mkDefault v;

      settingsFromJson =
        mkDefaultsRecursive
          (builtins.fromJSON (builtins.readFile ./noctalia.json));
    in {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        settings = settingsFromJson;
      };
    };
  };
}
