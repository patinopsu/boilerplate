{ inputs, den, ... }: {
  den.aspects.gpu-screen-recorder = {
    nixos = { pkgs, ... }: {
      programs.gpu-screen-recorder.enable = true;
    };
  };
}
