{ inputs, ... }: {
  den.aspects.secrets = { host, ... }: {
    nixos = { pkgs, ...}: {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops = {
        age.keyFile = "${host.settings.persistPath}/secrets/age-key.txt";
        age.generateKey = false;
      };

      environment.systemPackages = [
        pkgs.age
        pkgs.sops
      ];
    };
  };
}
