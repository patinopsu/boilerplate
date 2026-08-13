{
  den.aspects.bluetooth = {
    nixos = { lib, pkgs, ... }: {
      hardware.bluetooth.enable = true;
    };
  };
}
