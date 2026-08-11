{
  den.aspects.intelgpu = {
    nixos = { lib, pkgs, ... }: {
      hardware.graphics = {
        enable = lib.mkDefault true;
        extraPackages = with pkgs; [
          vpl-gpu-rt
          intel-media-driver
          intel-compute-runtime
        ];
      };
    };
  };
}
