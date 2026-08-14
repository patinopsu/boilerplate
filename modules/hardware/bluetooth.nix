{
  den.aspects.bluetooth = {
    nixos = { lib, pkgs, ... }: {
      preservation.preserveAt."/persistent" = {
        directories = [
          "/var/lib/bluetooth"
        ];
      };

      hardware.bluetooth.enable = true;
    };
  };
}
