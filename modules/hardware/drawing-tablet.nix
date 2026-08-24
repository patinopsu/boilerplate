{
  den.aspects.drawing-tablet = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".config/OpenTabletDriver/"
        ];
      };

      hardware.uinput.enable = true;
      boot.kernelModules = [ "uinput" ];

      hardware.opentabletdriver.enable = true;
    };
  };
}
