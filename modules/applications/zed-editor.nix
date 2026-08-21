{ inputs, den, ... }: {
  den.aspects.vscode = {
    nixos = { user, ...}: {
      preservation.preserveAt."/persistent".users.${user.name} = {
        directories = [
          ".config/zed"
        ];
      };
    };

    homeManager = {
      programs.zed-editor.enable = true;
    };
  };
}
