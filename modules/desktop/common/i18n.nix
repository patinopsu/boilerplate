{
  den.aspects.i18n = {
    nixos = {
      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocales = ["th_TH.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" ];
        extraLocaleSettings = {
          LC_MESSAGES = "en_US.UTF-8";
          LC_CTYPE = "en_US.UTF8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_TIME = "th_TH.UTF-8";
          LC_ADDRESS = "th_TH.UTF-8";
          LC_MEASUREMENT = "th_TH.UTF-8";
          LC_MONETARY = "th_TH.UTF-8";
          LC_NAME = "th_TH.UTF-8";
          LC_PAPER = "th_TH.UTF-8";
          LC_TELEPHONE = "th_TH.UTF-8";
          LC_COLLATE = "th_TH.UTF-8";
        };
      };
    };
  };
}
