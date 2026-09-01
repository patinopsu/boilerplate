{ inputs, ... }: {
  den.aspects.browsers = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".config/zen"
        ];
      };
    };
    homeManager = {
      imports = [
        inputs.zen-browser.homeModules.twilight-official
      ];

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/about" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/unknown" = [ "zen-twilight.desktop" ];
        };
      };

      programs.zen-browser = {
        enable = true;
        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
        };
        profiles."279p" = {
          sine.enable = true;
          sine.mods = [ "642854b5-88b4-4c40-b256-e035532109df" ];
        };
      };
      stylix.targets.zen-browser.enable = false;
    };
  };
}
