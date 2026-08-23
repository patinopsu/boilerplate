{
  den.aspects.bluetooth = { host, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}" = {
        directories = [
          "/var/lib/bluetooth"
        ];
      };

      hardware.bluetooth.enable = true;
    };
  };
}
