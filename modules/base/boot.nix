{ den, ... }: {
  den.aspects.boot = {
    nixos = { config, lib, pkgs, ... }: {
      boot.initrd.systemd.enable = true;
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
