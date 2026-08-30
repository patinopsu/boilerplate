{
  den.aspects.steam = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".local/share/Steam"
          ".steam"
          ".config/Steam"
        ];
      };

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = false;
        dedicatedServer.openFirewall = false;
      };
    };
  };
}
