{ inputs, den, ... }: {
  den.aspects.browsers = {
    nixos = { user, pkgs, ... }: {
      preservation.preserveAt."/persistent".users.${user.name} = {
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
        };
      };
      home.sessionVariables = {
        MOZ_DISABLE_RDD_SANDBOX = lib.mkDefault "1";  
      };
    };
  };
}
