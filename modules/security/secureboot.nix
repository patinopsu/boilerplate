{ inputs, ... }: {
  den.aspects.secureboot = { host, user, ... }: {
    nixos = { lib, pkgs, ... }: {
      imports = [
        inputs.lanzaboote.nixosModules.lanzaboote
      ];

      preservation.preserveAt."${host.settings.persistPath}" = {
        directories = [
          "/var/lib/sbctl"
          "/var/lib/auto-cryptenroll"
        ];
        files = [
          "/var/lib/systemd/pcrlock.json"
        ];
      };

      boot.loader.systemd-boot.enable = lib.mkForce false;
      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };

      environment.systemPackages = [
        pkgs.sbctl
      ];
    };
  };
}
