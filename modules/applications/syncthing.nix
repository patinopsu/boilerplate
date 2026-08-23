{ inputs, den, ... }: {
  den.aspects.syncthing = { host, user, ... }: {
    nixos = {
      services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        user = "${user.name}";
        dataDir = "${host.settings.persistPath}/syncthing/data";
        configDir = "${host.settings.persistPath}/syncthing/config";
      };
    };
  };
}
