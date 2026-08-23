{ inputs, den, ... }: {
  den.aspects.vscode = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".config/zed"
          ".local/share/zed"
        ];
      };
    };

    homeManager = {
      programs.zed-editor.enable = true;
    };
  };
}
