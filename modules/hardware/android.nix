{
  den.aspects.android = { user, ... }: {
    nixos = { pkgs, ... }: {
      preservation.preserveAt."/persistent".users.${user.name}.directories = [ ".android" ];
      environment.systemPackages = [ pkgs.android-tools ];
      users.users.${user.name}.extraGroups = [ "adbusers" ];

    };
  };
}
