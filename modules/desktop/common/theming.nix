{ self, inputs, ... }: {
  den.aspects.stylix = {
    nixos = { pkgs, ... }: {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        enable = true;
        autoEnable = true;
        polarity = "dark";
        base16Scheme = "${self.outPath}/assets/color-palette.yaml";

        fonts = {
          serif = {
            name = "Noto Serif";
            package = pkgs.noto-fonts;
          };
          
          sansSerif = {
            name = "Inter Display";
            package = pkgs.noto-fonts;
          };

          monospace = {
            name = "JetBrainsMono Nerd Font";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };

          emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts;
          };

          sizes = {
            desktop = 10.5;
            applications = 10.5;
            terminal = 12;
          };
        };

        opacity = {
          desktop = 0.80;
          terminal = 0.80;
          applications = 0.80;
        };

        icons = {
          enable = true;
          light = "Papirus-Light";
          dark = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };

        cursor = {
          name = "WhiteSur-cursors";
          package = pkgs.whitesur-cursors;
          size = 24;
        };
      };

      programs.dconf.profiles.user.databases = [{
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
          };
        };
      }];
    };
    
    homeManager = {
      gtk = {
        gtk3.extraConfig = {
          gtk-decoration-layout = "appmenu:minimize,maximize,close";
        };
        gtk4.extraConfig = {
          gtk-decoration-layout = "appmenu:minimize,maximize,close";
        };
      };
    };
  };
}
