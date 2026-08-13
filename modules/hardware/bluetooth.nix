{
  den.aspects.intelgpu = {
    nixos = { lib, pkgs, ... }: {
      hardware.bluetooth.enable = true;
    };
  };
}
