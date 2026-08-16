{ inputs, den, ... }: {
  den.aspects.qt-workaround = {
    nixos = { lib, pkgs, ... }: {
      stylix.targets.qt.enable = false;
      qt = {
        enable = true;
        platformTheme = "qt5ct";
        style = "kvantum";
      };
  
    };
    
    homeManager = { config, pkgs, lib, ... }: {
      stylix.targets.qt.enable = false;
      home.packages = [
        (with config.lib.stylix.colors; pkgs.writeTextFile {
          name = "CustomStylixScheme.colors";
          destination = "/share/color-schemes/CustomStylixScheme.colors";
          text = ''
            [General]
            ColorScheme=CustomStylixScheme
            Name=Custom Stylix Scheme

            [Colors:Window]
            BackgroundNormal=${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}
            BackgroundAlternate=${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}
            ForegroundNormal=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}
            ForegroundActive=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}
            ForegroundInactive=${base04-rgb-r},${base04-rgb-g},${base04-rgb-b}
            ForegroundNegative=${base08-rgb-r},${base08-rgb-g},${base08-rgb-b}
            ForegroundPositive=${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b}

            [Colors:View]
            BackgroundNormal=${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}
            BackgroundAlternate=${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}
            ForegroundNormal=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}
            ForegroundActive=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}
            ForegroundInactive=${base04-rgb-r},${base04-rgb-g},${base04-rgb-b}

            [Colors:Header]
            BackgroundNormal=${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}
            BackgroundAlternate=${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}
            ForegroundNormal=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}
            ForegroundActive=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}
            ForegroundInactive=${base04-rgb-r},${base04-rgb-g},${base04-rgb-b}

            [Colors:Button]
            BackgroundNormal=${base01-rgb-r},${base01-rgb-g},${base01-rgb-b}
            BackgroundAlternate=${base02-rgb-r},${base02-rgb-g},${base02-rgb-b}
            ForegroundNormal=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}
            ForegroundActive=${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}

            [Colors:Selection]
            BackgroundNormal=${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}
            BackgroundAlternate=${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}
            ForegroundNormal=${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}
            ForegroundActive=${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}
          '';
        })
      ];
    };
  };
}
