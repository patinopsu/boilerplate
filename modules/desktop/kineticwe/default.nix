{ inputs, den, ... }: {
  den.aspects.kineticwe = {
    includes = [
      den.aspects.i18n
      den.aspects.i2c
      den.aspects.fonts
      den.aspects.stylix
      den.aspects.noctalia-shell
      den.aspects.qt-workaround
    ];

    nixos = { lib, pkgs, host, user, ... }: {
      imports = [
        inputs.kineticwe.nixosModules.default
      ];

      preservation.preserveAt."/persistent" = {
        directories = [
          "/var/lib/AccountsService"
          {
            directory = "/var/lib/plasmalogin"; 
            user = "plasmalogin";
            group = "plasmalogin";
          }
        ];
      };

      preservation.preserveAt."/persistent".users.${user.name} = {
        directories = [
          ".config/klassy"

          ".local/share/dolphin"
          ".local/share/kwalletd"
        ];

        files = [
          # Appearance & Globals
          { file = ".config/kdeglobals"; how = "symlink"; }
          { file = ".config/kcminputrc"; how = "symlink"; }
          { file = ".config/kxkbrc"; how = "symlink"; }

          # # Window Management & KWin
          { file = ".config/kwinrc"; how = "symlink"; }
          { file = ".config/kwinrulesrc"; how = "symlink"; }
          { file = ".config/kwinoutputconfig.json"; how = "symlink"; }

          # # Daemons & Background Services
          { file = ".config/kscreenlockerrc"; how = "symlink"; }
          { file = ".config/ksmserverrc"; how = "symlink"; }

          # Power & Hardware
          { file = ".config/powerdevilrc"; how = "symlink"; }

          # # Shortcuts & Security
          { file = ".config/kglobalshortcutsrc"; how = "symlink"; }
          { file = ".config/kwalletrc"; how = "symlink"; }
          
          # # System Utilities & Apps
          { file = ".config/dolphinrc"; how = "symlink"; }      # File manager
          { file = ".config/spectaclerc"; how = "symlink"; }    # Screenshots
          { file = ".config/gwenviewrc"; how = "symlink"; }     # Image viewer

          # Miscellaneous / App integrations
          { file = ".config/libaccounts-glib"; how = "symlink"; }
          { file = ".config/QtProject.conf"; how = "symlink"; }
          { file = ".config/qtvirtualkeyboard"; how = "symlink"; }
          
          # Other / Misc Stuff
          { file = ".config/user-dirs.dirs"; how = "symlink"; }
          { file = ".config/mimeapps.list"; how = "symlink"; }
          { file = ".local/share/user-places.xbel"; how = "symlink"; }
          
        ];
      };

      services.displayManager.plasma-login-manager.enable = true;
      services.desktopManager.plasma6.enable = true;
      programs.kineticwe.enable = true;
      environment.systemPackages = with pkgs; [
        klassy
        kwin-script-geometry-change
        inputs.kwin-effects-better-blur-dx.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

    homeManager = { pkgs, ... }: {
      programs.noctalia.systemd.enable = false;
      stylix.targets.kde.enable = false;
    };
  };
}
