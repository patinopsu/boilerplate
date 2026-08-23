{
  den.aspects.boot = {
    nixos = { pkgs, ... }: {
      boot.initrd.systemd.enable = true;
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;
      zramSwap = {
        enable = true;
        memoryPercent = 50;
        algorithm = "zstd";
      };
    };
  };
}
