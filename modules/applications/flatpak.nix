{ inputs, ... }: {
  den.aspects.flatpak = { host, user, ... }: {
    nixos = {
      imports = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

      preservation.preserveAt."${host.settings.persistPath}" = {
        directories = [
          "/var/lib/flatpak"
        ];

        users.${user.name} = {
          directories = [
            ".var/app"
            ".local/share/flatpak"
          ];
        };
      };

      services.flatpak.enable = true;
      services.flatpak.remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
        {
          name = "flathub-beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
      ];

      services.flatpak.packages = [
        { appId = "io.github.kolunmi.Bazaar"; origin = "flathub"; }
      ];
    };
  };
}
