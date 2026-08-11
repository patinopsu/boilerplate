{ den, ... }: {
  den.aspects.i2c = { user, ... }: {
    nixos = {
      hardware.i2c.enable = true;
      users.users.${user.name}.extraGroups = [ "i2c" ];
    };
  };
}
