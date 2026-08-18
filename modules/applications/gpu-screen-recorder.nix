{ inputs, den, ... }: {
  den.aspects.gpu-screen-recorder = {
    nixos = { user, pkgs, ... }: {
      programs.gpu-screen-recorder.enable = true;
    };
  };
}
