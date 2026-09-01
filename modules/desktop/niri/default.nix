{ den, ... }: {
  den.aspects.niri = { host, user, ... }: {
    includes = [
      den.aspects.i18n
      den.aspects.i2c
      den.aspects.fonts
      den.aspects.stylix
      den.aspects.noctalia-shell

      den.aspects.mimeapps
      den.aspects.file-manager
      den.aspects.document-viewer
      den.aspects.image-viewer
      den.aspects.gpu-screen-recorder
      den.aspects.kitty
      den.aspects.mpv
      den.aspects.vicinae
    ];

    nixos = { pkgs, ... }: {
      preservation.preserveAt."${host.settings.persistPath}" = {
        directories = [
          "/var/lib/AccountsService"
        ];
        users.${user.name} = {
          directories = [
            ".config/autostart"
            ".local/share/applications"
            ".local/share/keyrings"
          ];
        };
      };

      services = {
        udisks2.enable = true;
        gvfs.enable = true;

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

      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        wl-mirror
        wl-clipboard
      ];
    };

    homeManager = {
      wayland.windowManager.niri = {
        enable = true;
        settings = {
          input = {
            mouse.accel-profile = "flat";

            keyboard = {
              numlock = true;
              repeat-delay = 500;

              xkb = {
                layout = "us,th";
                options = "caps:none,grp:alt_caps_toggle,grp:caps_toggle,grp:shift_caps_toggle";
              };
            };
          };

          clipboard.disable-primary = {};
          hotkey-overlay.skip-at-startup = {};

          layout = {
            gaps = 10;
            center-focused-column = "never";
            background-color = "transparent";
            default-column-width.proportion = 0.5;
            focus-ring.off = {};
            border.width = 2;
          };

          prefer-no-csd = {};
          overview.workspace-shadow.off = {};

          binds = {
            "Mod+Tab" = {
              _props.repeat = false;
              toggle-overview = {};
            };

            "Mod+Q" = {
              _props.repeat = false;
              close-window = {};
            };

            "Mod+Return" = {
              _props.hotkey-overlay-title = "Open a Good-Ol Terminal";
              spawn = ["kitty"];
            };

            "Alt+Space" = {
              _props.hotkey-overlay-title = "Open Vicinae, An App Launcher";
              spawn = ["vicinae" "toggle"];
            };

            "Mod+E" = {
              _props.hotkey-overlay-title = "Open File Manager";
              spawn-sh = "kitty -e yazi";
            };

            "Mod+V" = {
              _props.hotkey-overlay-title = "Clipboard History";
              spawn = ["xdg-open" "vicinae://launch/clipboard/history"];
            };

            "Mod+L" = {
              _props.hotkey-overlay-title = "Lock the System";
              spawn = ["noctalia" "msg" "session" "lock"];
            };

            "XF86AudioPlay" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "media" "next"];
            };

            "XF86AudioStop" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "media" "pause"];
            };

            "XF86AudioPrev" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "media" "previous"];
            };

            "XF86AudioNext" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "media" "next"];
            };

            "XF86MonBrightnessUp" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "brightness-up"];
            };

            "XF86MonBrightnessDown" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "brightness-down"];
            };

            "XF86AudioRaiseVolume" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "volume-up"];
            };

            "XF86AudioLowerVolume" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "volume-down"];
            };

            "XF86AudioMute" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "volume-mute"];
            };

            "XF86AudioMicMute" = {
              _props.allow-when-locked = true;
              spawn = ["noctalia" "msg" "mic-mute"];
            };

            "Mod+K" = {
              _props.hotkey-overlay-title = "Open Wallpaper Selector";
              spawn = ["noctalia" "msg" "panel-toggle" "wallpaper"];
            };

            "Ctrl+Alt+Delete" = {
              _props.hotkey-overlay-title = "Open Session Menu";
              spawn = ["noctalia" "msg" "panel-toggle" "session"];
            };

            "Print" = {
              _props = {
                allow-when-locked = false;
                hotkey-overlay-title = "Screenshot Region";
              };
              spawn = ["noctalia" "msg" "screenshot-region"];
            };

            "Ctrl+Print" = {
              _props = {
                allow-when-locked = false;
                hotkey-overlay-title = "Record Current Focused Screen";
              };
              spawn = ["noctalia" "msg" "plugin" "noctalia/screen_recorder:service" "all" "toggle"];
            };

            "Mod+Print" = {
              _props = {
                allow-when-locked = false;
                hotkey-overlay-title = "Screenshot Active Monitor";
              };
              spawn = ["noctalia" "msg" "screenshot-fullscreen"];
            };

            "Mod+A".focus-column-left = {};
            "Mod+D".focus-column-right = {};
            "Mod+Shift+A".move-column-left = {};
            "Mod+Shift+D".move-column-right = {};

            "Mod+Home".focus-column-first = {};
            "Mod+End".focus-column-last = {};
            "Mod+Ctrl+Home".move-column-to-first = {};
            "Mod+Ctrl+End".move-column-to-last = {};

            "Mod+Shift+Left".focus-monitor-left = {};
            "Mod+Shift+Down".focus-monitor-down = {};
            "Mod+Shift+Up".focus-monitor-up = {};
            "Mod+Shift+Right".focus-monitor-right = {};
            "Mod+Shift+H".focus-monitor-left = {};
            "Mod+Shift+J".focus-monitor-down = {};
            "Mod+Shift+K".focus-monitor-up = {};
            "Mod+Shift+L".focus-monitor-right = {};

            "Mod+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              focus-workspace-down = {};
            };

            "Mod+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              focus-workspace-up = {};
            };

            "Mod+Ctrl+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              move-column-to-workspace-down = {};
            };

            "Mod+Ctrl+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              move-column-to-workspace-up = {};
            };

            "Mod+WheelScrollRight".focus-column-right = {};
            "Mod+WheelScrollLeft".focus-column-left = {};
            "Mod+Ctrl+WheelScrollRight".move-column-right = {};
            "Mod+Ctrl+WheelScrollLeft".move-column-left = {};

            "Mod+Shift+WheelScrollDown".focus-column-right = {};
            "Mod+Shift+WheelScrollUp".focus-column-left = {};
            "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = {};
            "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = {};

            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;
            "Mod+0".focus-workspace = 0;

            "Mod+Ctrl+1".move-column-to-workspace = 1;
            "Mod+Ctrl+2".move-column-to-workspace = 2;
            "Mod+Ctrl+3".move-column-to-workspace = 3;
            "Mod+Ctrl+4".move-column-to-workspace = 4;
            "Mod+Ctrl+5".move-column-to-workspace = 5;
            "Mod+Ctrl+6".move-column-to-workspace = 6;
            "Mod+Ctrl+7".move-column-to-workspace = 7;
            "Mod+Ctrl+8".move-column-to-workspace = 8;
            "Mod+Ctrl+9".move-column-to-workspace = 9;
            "Mod+Ctrl+0".move-column-to-workspace = 0;

            "Mod+BracketLeft".consume-or-expel-window-left = {};
            "Mod+BracketRight".consume-or-expel-window-right = {};

            "Mod+F".maximize-column = {};
            "Mod+Shift+F".fullscreen-window = {};
            "Mod+Ctrl+F".expand-column-to-available-width = {};

            "Mod+C".center-column = {};
            "Mod+Ctrl+C".center-visible-columns = {};

            "Mod+Minus".set-column-width = "-4%";
            "Mod+Equal".set-column-width = "+4%";

            "Mod+Alt+V".toggle-window-floating = {};
            "Mod+Shift+Slash".show-hotkey-overlay = {};
          };
        };

        extraConfig = ''
          layer-rule {
            match namespace="^noctalia-backdrop"
            place-within-backdrop true
          }

          window-rule {
            // Rounded corners for a modern look.
            geometry-corner-radius 10

            // Clips window contents to the rounded corner boundaries.
            clip-to-geometry true
          }

          window-rule {
            match app-id="dev.noctalia.Noctalia"
            open-floating true
            default-column-width { fixed 1080; }
            default-window-height { fixed 920; }
          }

          layer-rule {
            match namespace="^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"
            background-effect {
              xray false
              // blur false
            }
          }

          blur {
            passes 2        // more passes = stronger blur (default: 3)
            offset 3.0      // sample distance per pass (default: 3.0)
            noise 0.03      // grain overlay (default: 0.02)
            saturation 1.0  // color saturation boost (default: 1.5)
          }

          debug {
            // Allows notification actions and window activation from Noctalia.
            honor-xdg-activation-with-invalid-serial
          }
        '';
      };

      services.udiskie = {
        enable = true;
      };
    };
  };
}
