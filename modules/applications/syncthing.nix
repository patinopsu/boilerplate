{ inputs, den, ... }: {
  den.aspects.syncthing = { user, ... }: {
    nixos = {
      services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = "${user.name}";
        dataDir = "/persistent/syncthing/data";
        configDir = "/persistent/syncthing/config";
      };
    };
  };
}
