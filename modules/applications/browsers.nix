{ inputs, den, ... }: {
  den.aspects.browsers = { host, user, ... }: {
    nixos = { pkgs, ... }: {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".config/zen"
        ];
      };
    };
    homeManager = { lib, ... }: {
      imports = [
        inputs.zen-browser.homeModules.twilight-official
      ];

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
          sine.mods = [
            "642854b5-88b4-4c40-b256-e035532109df"
          ];
        };
      };
      home.sessionVariables = {
        MOZ_DISABLE_RDD_SANDBOX = lib.mkDefault "1";
      };
    };
  };
}
