{ inputs, den, ... }: {
  den.aspects.vscode = {
    nixos = { user, ...}: {
      preservation.preserveAt."/persistent".users.${user.name} = {
        directories = [
          ".vscode"
          ".vscode-shared"
          ".config/Code"
        ];
      };
    };

    homeManager = {
      programs.vscode.enable = true;
      stylix.targets.vscode.enable = false;
    };
  };
}
