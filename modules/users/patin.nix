{ den, ... }: {
  den.aspects.patin = { host, user, ... }: {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.batteries.host-aspects
      (den.batteries.user-shell "zsh")
    ];

    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".ssh"
          ".local/state"
        ];
      };

      users.mutableUsers = false;

      users.users.${user.name} = {
        isNormalUser = true;
        description = "Patin Muangjan";
	      initialPassword = "changeme";
        extraGroups = ["wheel"];
      };
    };
  };
}
