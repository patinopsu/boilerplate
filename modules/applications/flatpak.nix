{ inputs, ... }: {
  den.aspects.flatpak = {
    nixos = { user, pkgs, ... }: {
      imports = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];

      preservation.preserveAt."/persistent" = {
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
    };
  };
}