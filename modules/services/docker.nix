{ den, ... }: {
  den.aspects.docker = { user, ... }: {
    nixos = {
      preservation.preserveAt."/persistent".directories = [
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
