{
  den.aspects.i2c = { user, ... }: {
    nixos = { pkgs, ... }: {
      hardware.i2c.enable = true;
      users.users.${user.name}.extraGroups = [ "i2c" ];

      environment.systemPackages = [
        pkgs.ddcutil
      ];
    };
  };
}
