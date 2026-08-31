{
  den.aspects.input-method = {
    nixos = { pkgs, ... }: {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          ignoreUserConfig = true;
          waylandFrontend = true;
          addons = with pkgs; [ fcitx5-mozc ];
          settings = {
            globalOptions = {
              Hotkey = {
                EnumerateWithTriggerKeys = true;
                EnumerateForwardKeys = "";
                EnumerateBackwardKeys = "";
                EnumerateSkipFirst = false;
                ModifierOnlyKeyTimeout = 250;
              };

              "Hotkey/TriggerKeys" = {
                "0" = "Super+space";
              };

              "Hotkey/ActivateKeys" = {
                "0" = "Hangul_Hanja";
              };

              "Hotkey/DeactivateKeys" = {
                "0" = "Hangul_Romaja";
              };

              "Hotkey/AltTriggerKeys" = {
                "0" = "Shift_L";
              };

              "Hotkey/EnumerateGroupForwardKeys" = {
                "0" = "Control+space";
              };

              "Hotkey/EnumerateGroupBackwardKeys" = {
                "0" = "Shift+Super+space";
              };

              "Hotkey/PrevPage" = {
                "0" = "Up";
              };

              "Hotkey/NextPage" = {
                "0" = "Down";
              };

              "Hotkey/PrevCandidate" = {
                "0" = "Shift+Tab";
              };

              "Hotkey/NextCandidate" = {
                "0" = "Tab";
              };

              "Hotkey/TogglePreedit" = {
                "0" = "Control+Alt+P";
              };

              Behavior = {
                ActiveByDefault = false;
                resetStateWhenFocusIn = "No";
                ShareInputState = "No";
                PreeditEnabledByDefault = true;
                ShowInputMethodInformation = true;
                showInputMethodInformationWhenFocusIn = false;
                CompactInputMethodInformation = true;
                ShowFirstInputMethodInformation = true;
                DefaultPageSize = 5;
                OverrideXkbOption = true;
                CustomXkbOption = "caps:none";
                EnabledAddons = "";
                DisabledAddons = "";
                PreloadInputMethod = true;
                AllowInputMethodForPassword = false;
                ShowPreeditForPassword = false;
                AutoSavePeriod = 30;
              };
            };
            inputMethod = {
              GroupOrder."0" = "Theme of Mitsuha";
              "Groups/0" = {
                Name = "Theme of Mitsuha";
                "Default Layout" = "us";
                DefaultIM = "keyboard-us";
              };

              "Groups/0/Items/0" = {
                Name = "keyboard-us";
                Layout = "";
              };

              "Groups/0/Items/1" = {
                Name = "keyboard-th";
                Layout = "";
              };

              "Groups/0/Items/2" = {
                Name = "mozc";
                Layout = "us";
              };
            };
          };
        };
      };
    };
  };
}
