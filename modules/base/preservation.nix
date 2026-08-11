{ inputs, den, ... }: {
  den.aspects.preservation.nixos = {
    imports = [
      inputs.preservation.nixosModules.default
    ];
    preservation = {
      enable = true;

      preserveAt."/persistent" = {
        directories = [
          "/etc/nixos"
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
        ];
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];
      };
    };
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
