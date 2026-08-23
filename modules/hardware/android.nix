{
  den.aspects.android = { host, user, ... }: {
    nixos = { pkgs, ... }: {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name}.directories = [ ".android" ];
      environment.systemPackages = [ pkgs.android-tools ];
      users.users.${user.name}.extraGroups = [ "adbusers" ];

    };
  };
}
