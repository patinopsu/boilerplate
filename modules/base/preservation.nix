{ inputs, ... }: {
  den.aspects.preservation.nixos = { host, ... }: {
    imports = [
      inputs.preservation.nixosModules.default
    ];
    preservation = {
      enable = true;

      preserveAt."${host.settings.persistPath}" = {
        directories = [
          "/etc/nix"
          { directory = "/var/lib/nixos"; inInitrd = true; }
          { directory = "/var/lib/systemd/backlight"; inInitrd = true; }
          { directory = "/var/lib/systemd/timers"; inInitrd = true; }
          { directory = "/var/lib/systemd/coredump"; inInitrd = true; }
          { directory = "/var/lib/systemd/timesync"; inInitrd = true; }
        ];
        files = [
          "/var/lib/systemd/credential.secret"
          { file = "/etc/machine-id"; inInitrd = true; }
        ];
      };
    };

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
