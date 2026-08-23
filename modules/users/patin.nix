{ den, ... }: {
  den.aspects.patin = { host, user, ... }: {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.batteries.host-aspects
    ];

    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".ssh"
          ".local/state"
        ];
      };

      programs.zsh.enable = true;
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
