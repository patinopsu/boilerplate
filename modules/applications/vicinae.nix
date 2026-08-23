{ inputs, ... }: {
  den.aspects.vicinae = {
    homeManager = {
      imports = [
        inputs.vicinae.homeManagerModules.default
      ];

      programs.vicinae = {
        enable = true;
        systemd = {
          enable = true;
          autoStart = true;
          environment = {
            USE_LAYER_SHELL = 1;
          };
        };
      };
    };
  };
}
