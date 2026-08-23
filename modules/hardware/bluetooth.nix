{
  den.aspects.bluetooth = { host, ... }: {
    nixos = { lib, pkgs, ... }: {
      preservation.preserveAt."${host.settings.persistPath}" = {
        directories = [
          "/var/lib/bluetooth"
        ];
      };

      hardware.bluetooth.enable = true;
    };
  };
}
