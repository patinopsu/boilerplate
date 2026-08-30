{ inputs, ... }: {
  den.aspects.spotify = { host, user, ... }: {
    nixos = { pkgs, ... }: {
      imports = [
        inputs.spicetify-nix.nixosModules.spicetify
      ];

      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".config/spotify"
        ];
      };

      programs.spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
      in {
        enable = true;
        alwaysEnableDevTools = true;
        experimentalFeatures = true;
        spotifyLaunchFlags = "--disable-gpu --use-gl=swiftshader";
        theme = spicePkgs.themes.hazy;
        enabledExtensions = with spicePkgs.extensions; [
          adblockify
          hidePodcasts
          shuffle
        ];
      };
      stylix.targets.spicetify.enable = false;
    };
  };
}
