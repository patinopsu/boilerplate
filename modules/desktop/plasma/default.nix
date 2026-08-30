{ inputs, den, ... }: {
  den.aspects.plasma = {
    includes = [
      den.aspects.i18n
      den.aspects.i2c
      den.aspects.fonts
      den.aspects.stylix
      den.aspects.file-manager
      den.aspects.input-method
    ];

    nixos = { pkgs, user, ... }: {
      preservation.preserveAt."/persistent" = {
        directories = [
          "/var/lib/AccountsService"
          { directory = "/var/lib/plasmalogin"; user = "plasmalogin"; group = "plasmalogin"; }
        ];
      };

      preservation.preserveAt."/persistent".users.${user.name} = {
        directories = [
          ".config/autostart"
          ".local/share/klipper"
          ".local/share/dolphin"
          ".local/share/kwalletd"
        ];

        files = [
          # Core Plasma Configs
          { file = ".config/plasmarc"; how = "symlink"; }
          { file = ".config/plasmashellrc"; how = "symlink"; }
          { file = ".config/plasma-org.kde.plasma.desktop-appletsrc"; how = "symlink"; }
          { file = ".config/plasma-localerc"; how = "symlink"; }

          # Appearance & Globals
          { file = ".config/kdeglobals"; how = "symlink"; }
          { file = ".config/kcminputrc"; how = "symlink"; }
          # { file = ".config/kxkbrc"; how = "symlink"; }
          # { file = ".config/xsettings"; how = "symlink"; }

          # Window Management & KWin
          { file = ".config/kwinrc"; how = "symlink"; }
          { file = ".config/kwinrulesrc"; how = "symlink"; }
          { file = ".config/kwinoutputconfig.json"; how = "symlink"; }

          # Daemons & Background Services
          # { file = ".config/kded5rc"; how = "symlink"; }
          # { file = ".config/kded6rc"; how = "symlink"; }
          # { file = ".config/kdedefaults"; how = "symlink"; }
          { file = ".config/kconf_updaterc"; how = "symlink"; }
          { file = ".config/kactivitymanagerdrc"; how = "symlink"; }
          { file = ".config/kactivitymanagerd-statsrc"; how = "symlink"; }
          #  file = ".config/ktimezonedrc"; how = "symlink"; }
          { file = ".config/kscreenlockerrc"; how = "symlink"; }
          { file = ".config/ksmserverrc"; how = "symlink"; }

          # Power & Hardware
          { file = ".config/powerdevilrc"; how = "symlink"; }
          # { file = ".config/powermanagementprofilesrc"; how = "symlink"; }
          { file = ".config/baloofilerc"; how = "symlink"; }
          { file = ".config/baloofileinformationrc"; how = "symlink"; }

          # Shortcuts & Security
          { file = ".config/kglobalshortcutsrc"; how = "symlink"; }
          { file = ".config/kwalletrc"; how = "symlink"; }
          { file = ".config/klipperrc"; how = "symlink"; }      # Clipboard history

          # System Utilities & Apps
          { file = ".config/dolphinrc"; how = "symlink"; }      # File manager
          { file = ".config/spectaclerc"; how = "symlink"; }    # Screenshots
          { file = ".config/gwenviewrc"; how = "symlink"; }     # Image viewer
          # { file = ".config/konsolerc"; how = "symlink"; }      # Terminal emulator
          # { file = ".config/konsolesshconfig"; how = "symlink"; }
          #{ file = ".config/discoverrc"; how = "symlink"; }     # Package manager GUI
          { file = ".config/drkonqirc"; how = "symlink"; }      # Crash handler
          { file = ".config/okularrc"; how = "symlink"; } # Document Viewer
          { file = ".config/okularpartrc"; how = "symlink"; }
          # { file = ".config/khelpcenterrc"; how = "symlink"; }
          { file = ".config/kiorc"; how = "symlink"; }
          { file = ".config/krunnerrc"; how = "symlink"; }      # Alt+Space search runner
          { file = ".config/plasmanotifyrc"; how = "symlink"; } # Notifications
          # { file = ".config/plasmaparc"; how = "symlink"; }     # Plasma audio/multimedia
          # { file = ".config/systemmonitorrc"; how = "symlink"; }

          # Miscellaneous / App integrations
          #{ file = ".config/libaccounts-glib"; how = "symlink"; }
          # { file = ".config/QtProject.conf"; how = "symlink"; }
          # { file = ".config/qtvirtualkeyboard"; how = "symlink"; }

          # Other / Misc Stuff
          { file = ".local/share/user-places.xbel"; how = "symlink"; }
        ];
      };

      services.displayManager.plasma-login-manager.enable = true;
      services.desktopManager.plasma6.enable = true;

      environment.systemPackages = with pkgs; [
        kwin-script-geometry-change
        inputs.kwin-effects-better-blur-dx.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        elisa
        kate
        konsole
        khelpcenter
        discover
      ];
    };
  };
}
