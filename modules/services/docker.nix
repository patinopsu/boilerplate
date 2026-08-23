{
  den.aspects.docker = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".directories = [
        "/var/lib/docker"
      ];

      virtualisation.docker = {
        enable = true;
        storageDriver = "btrfs";
      };

      users.users.${user.name}.extraGroups = [ "docker" ];
    };
  };
}
