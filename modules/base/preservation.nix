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
          "/etc/nix"
          {
            directory = "/var/lib/backlight";
            inInitrd = true;
          }
          {
            directory = "/var/lib/systemd/timers";
            inInitrd = true;
          }
          {
            directory = "/var/lib/coredump";
            inInitrd = true;
          }
          {
            directory = "/var/lib/timesync";
            inInitrd = true;
          }  
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
        ];
        files = [
          "/var/lib/systemd/credential.secret"
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
