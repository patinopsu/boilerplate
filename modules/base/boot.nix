{
  den.aspects.boot = {
    nixos = { pkgs, lib, ... }: {
      boot.loader.timeout = 0;
      boot.initrd.systemd.enable = true;
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      zramSwap = {
        enable = true;
        memoryPercent = 50;
        algorithm = "zstd";
      };
    };
  };
}
