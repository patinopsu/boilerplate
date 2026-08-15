{ inputs, den, ... }: {
  den.aspects.qt-fix = {
    includes = [
      den.aspects.i18n
      den.aspects.i2c
      den.aspects.fonts
      den.aspects.stylix
      den.aspects.noctalia-shell
      den.aspects.qt-workaround
    ];

    nixos = { lib, pkgs, host, user, ... }: {
      stylix.targets.qt.enable = false;

      qt = {
        enable = true;
        style = "kvantum";
      };
    };
  };
}
