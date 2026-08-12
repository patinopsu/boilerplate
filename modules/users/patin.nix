{ den, ... }: {
  den.aspects.patin = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.batteries.host-aspects
      (den.batteries.user-shell "zsh")
    ];

    nixos = { lib, user, pkgs, ... }: {
      preservation.preserveAt."/persistent".users.${user.name} = {
        directories = [
          ".local/state"
        ];
      };

      programs.zsh.enable = true;
      users.mutableUsers = false;
      users.users.${user.name} = {
        isNormalUser = true;
        description = "Patin Muangjan";
        hashedPasswordFile = "/persistent/secure/hashedpw";
        extraGroups = ["wheel"];
      };
    };
  };
}
