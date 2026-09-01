{ inputs, ... }: {
  den.aspects.vicinae = {
    nixos = {
      nix.settings = {
        substituters = [ "https://vicinae.cachix.org" ];
        trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
      };
    };

    homeManager = {
      imports = [ inputs.vicinae.homeManagerModules.default ];
      programs.vicinae = {
        enable = true;
        systemd = { enable = true; autoStart = true; };
      };
    };
  };
}
