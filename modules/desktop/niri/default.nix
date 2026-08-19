{ den, inputs, self, ... }: {
  den.aspects.niri = {
    includes = [
      den.aspects.i18n
      den.aspects.i2c
      den.aspects.fonts
      den.aspects.stylix
      den.aspects.file-manager
      den.aspects.gpu-screen-recorder
      den.aspects.noctalia-shell
    ];

    nixos = { config, lib, pkgs, user, ... }: {
      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];

      preservation.preserveAt."/persistent".users.${user.name} = {
        directories = [
          ".local/share/keyrings"
        ];
        
        files = [
          { file = ".config/user-dirs.dirs"; how = "symlink"; }
          { file = ".config/mimeapps.list"; how = "symlink"; }
        ];
      };

      services = {
        udisks2.enable = true;
        gvfs.enable = true;

        gnome = lib.mkForce {
          gnome-keyring.enable = true;
          gcr-ssh-agent.enable = false;
        };

        displayManager.ly = {
          enable = true;
          settings = {
            animation = "colormix";
            bigclock = "en";
            brightness_down_key = "";
            brightness_up_key = "";
            clock = "%c";
            edge_margin = "1";
          };
        };
      };

      programs = {
        niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };
        uwsm = {
          enable = true;
          waylandCompositors = {
            niri = {
              prettyName = "Niri";
              comment = "Niri compositor managed by UWSM";
              binPath = "${pkgs.niri}/bin/niri-session";
            };
          };
        };
      };

      systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";

      environment.systemPackages = with pkgs; [
        loupe
        xwayland-satellite
        wl-clipboard
      ];
    };

    homeManager = { config, lib, pkgs, ... }: {
      imports = [
        inputs.niri.homeModules.niri
      ];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
        settings = {
          input = {
            mouse = {
              accel-profile = "flat";
            };
            keyboard = {
              numlock = true;
              repeat-delay = 500;
              xkb = {
                layout = "us,th";
                options = "caps:none,grp:alt_caps_toggle,grp:caps_toggle,grp:shift_caps_toggle";
              };
            };
          };
          layout = {
            gaps = 10;
            center-focused-column = "never";
            background-color = "transparent";
            default-column-width.proportion = 0.5;
            focus-ring = {
              enable = false;
            };

            border = {
              enable = true;
              width = 2;
            };
          };

          prefer-no-csd = true;
          overview = {
            workspace-shadow.enable = true;
          };

          binds = {
            "Mod+Tab" = {
              repeat = false;
              action.toggle-overview = [];
            };

            "Mod+Q" = {
              repeat = false;
              action.close-window = [];
            };

            "Mod+Return" = {
              hotkey-overlay.title = "Open a Good-Ol Terminal";
              action.spawn = [ "${pkgs.kitty}/bin/kitty" ];
            };

            "Alt+Space" = {
              hotkey-overlay.title = "Open Vicinae, An App Launcher";
              action.spawn = [ "vicinae" "toggle" ];
            };

            "Mod+E" = {
              hotkey-overlay.title = "Open File Manager";
              action.spawn = [ "${pkgs.kitty}/bin/kitty" "yazi" ];
            };

            "Mod+V" = {
              hotkey-overlay.title = "Clipboard History";
              action.spawn = [ "xdg-open" "vicinae://launch/clipboard/history" ];
            };

            "Mod+L" = {
              hotkey-overlay.title = "Lock the System";
              action.spawn = [ "noctalia" "msg" "session" "lock"  ];
            };

            "XF86AudioPlay" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "media" "next" ];
            };

            "XF86AudioStop" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "media" "pause" ];
            };

            "XF86AudioPrev" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "media" "previous" ];
            };

            "XF86AudioNext" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "media" "next" ];
            };

            "XF86MonBrightnessUp" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "brightness-up" ];
            };

            "XF86MonBrightnessDown" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "brightness-down" ];
            };

            "XF86AudioRaiseVolume" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "volume-up" ];
            };

            "XF86AudioLowerVolume" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "volume-down" ];
            };

            "XF86AudioMute" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "volume-mute" ];
            };

            "XF86AudioMicMute" = {
              allow-when-locked = true;
              action.spawn = [ "noctalia" "msg" "mic-mute" ];
            };

            "Mod+K" = {
              hotkey-overlay.title = "Open Wallpaper Selector";
              action.spawn = [ "noctalia" "msg" "panel-toggle" "wallpaper" ];
            };

            "Ctrl+Alt+Delete" = {
              hotkey-overlay.title = "Open Session Menu";
              action.spawn = [ "noctalia" "msg" "panel-toggle" "session" ];
            };

            "Print" = {
              allow-when-locked = false;
              hotkey-overlay.title = "Screenshot Region";
              action.spawn = [ "noctalia" "msg" "screenshot-region" ];
            };

            "Ctrl+Print" = {
              allow-when-locked = false;
              hotkey-overlay.title = "Screenshot Region";
              action.spawn = [ "noctalia" "msg" "plugin" "noctalia/screen_recorder:service" "all" "toggle" ];
            };

            "Mod+Print" = {
              allow-when-locked = false;
              hotkey-overlay.title = "Screenshot Active Monitor";
              action.spawn = [ "noctalia" "msg" "screenshot-fullscreen" ];
            };

            "Mod+A".action.focus-column-left = [];
            "Mod+D".action.focus-column-right = [];
            "Mod+Shift+A".action.move-column-left = [];
            "Mod+Shift+D".action.move-column-right = [];

            "Mod+Home".action.focus-column-first = [];
            "Mod+End".action.focus-column-last = [];
            "Mod+Ctrl+Home".action.move-column-to-first = [];
            "Mod+Ctrl+End".action.move-column-to-last = [];

            "Mod+Shift+Left".action.focus-monitor-left = [];
            "Mod+Shift+Down".action.focus-monitor-down = [];
            "Mod+Shift+Up".action.focus-monitor-up = [];
            "Mod+Shift+Right".action.focus-monitor-right = [];
            "Mod+Shift+H".action.focus-monitor-left = [];
            "Mod+Shift+J".action.focus-monitor-down = [];
            "Mod+Shift+K".action.focus-monitor-up = [];
            "Mod+Shift+L".action.focus-monitor-right = [];

            "Mod+WheelScrollDown".cooldown-ms = 150;
            "Mod+WheelScrollDown".action.focus-workspace-down = [];

            "Mod+WheelScrollUp".cooldown-ms = 150;
            "Mod+WheelScrollUp".action.focus-workspace-up = [];

            "Mod+Ctrl+WheelScrollDown".cooldown-ms = 150;
            "Mod+Ctrl+WheelScrollDown".action.move-column-to-workspace-down = [];

            "Mod+Ctrl+WheelScrollUp".cooldown-ms = 150;
            "Mod+Ctrl+WheelScrollUp".action.move-column-to-workspace-up = [];

            "Mod+WheelScrollRight".action.focus-column-right = [];
            "Mod+WheelScrollLeft".action.focus-column-left = [];
            "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
            "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];

            "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
            "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
            "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
            "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];

            "Mod+1".action.focus-workspace = 1;
            "Mod+2".action.focus-workspace = 2;
            "Mod+3".action.focus-workspace = 3;
            "Mod+4".action.focus-workspace = 4;
            "Mod+5".action.focus-workspace = 5;
            "Mod+6".action.focus-workspace = 6;
            "Mod+7".action.focus-workspace = 7;
            "Mod+8".action.focus-workspace = 8;
            "Mod+9".action.focus-workspace = 9;
            "Mod+0".action.focus-workspace = 0;

            "Mod+Ctrl+1".action.move-column-to-workspace = 1;
            "Mod+Ctrl+2".action.move-column-to-workspace = 2;
            "Mod+Ctrl+3".action.move-column-to-workspace = 3;
            "Mod+Ctrl+4".action.move-column-to-workspace = 4;
            "Mod+Ctrl+5".action.move-column-to-workspace = 5;
            "Mod+Ctrl+6".action.move-column-to-workspace = 6;
            "Mod+Ctrl+7".action.move-column-to-workspace = 7;
            "Mod+Ctrl+8".action.move-column-to-workspace = 8;
            "Mod+Ctrl+9".action.move-column-to-workspace = 9;
            "Mod+Ctrl+0".action.move-column-to-workspace = 0;

            "Mod+BracketLeft".action.consume-or-expel-window-left = [];
            "Mod+BracketRight".action.consume-or-expel-window-right = [];

            "Mod+F".action.maximize-column = [];
            "Mod+Shift+F".action.fullscreen-window = [];
            "Mod+Ctrl+F".action.expand-column-to-available-width = [];

            "Mod+C".action.center-column = [];
            "Mod+Ctrl+C".action.center-visible-columns = [];

            "Mod+Minus".action.set-column-width = "-4%";
            "Mod+Equal".action.set-column-width = "+4%";

            "Mod+Alt+V".action.toggle-window-floating = [];
            "Mod+Shift+Slash".action.show-hotkey-overlay = [];
          };

          window-rules = [
            {
              "background-effect" = {
                blur = true;
              };
            }
            {
              "geometry-corner-radius" = {
                "top-left" = 10.0;
                "top-right" = 10.0;
                "bottom-left" = 10.0;
                "bottom-right" = 10.0;
              };
              "clip-to-geometry" = true;
            }
            {
              matches = [{ "app-id" = "r#^zen-twilight$#"; title = "^Picture-in-Picture$"; }];
              "open-floating" = true;
            }
            {
              matches = [{ "app-id" = "r#^zen-twilight$#"; }];
              "draw-border-with-background" = false;
              "opacity" = 0.98;
            }
          ];
          layer-rules = [
            {
              matches = [{ namespace = "^noctalia-backdrop"; }];
              "place-within-backdrop" = true;
            }
            {
              matches = [{namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";}];
              "background-effect" = {
                xray = false;
              };
            }
          ];
        };
      };

      services.udiskie = {
        enable = true;
      };
    };
  };
}
