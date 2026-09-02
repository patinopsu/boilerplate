# Search "Ms.Okudera" on Google and You'll know what I am referencing to

{
  den.aspects.seanime = { host, user, ... }: {
    nixos = { pkgs, ... }: {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".config/seanime"
        ];
      };
      environment.systemPackages = [
        pkgs.seanime
      ];
    };
  };
}
