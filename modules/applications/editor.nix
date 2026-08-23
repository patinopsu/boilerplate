{
  den.aspects.vscode = { host, user, ... }: {
    nixos = { pkgs, ... }: {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".config/zed"
          ".local/share/zed"
        ];
      };
      environment.systemPackages = [
        pkgs.nil
        pkgs.nixd
      ];
    };

    homeManager = {
      programs.zed-editor.enable = true;
      stylix.targets.zed.enable = false;
    };
  };
}
