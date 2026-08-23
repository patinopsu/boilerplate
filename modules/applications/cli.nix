{ inputs, ... }: {
  den.aspects.zsh = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".local/share/atuin"
          ".local/share/zoxide"
        ];
      };
    };

    homeManager = { pkgs, ... }: {
      imports = [
        inputs.nix-index-database.homeModules.default
      ];

      programs.nix-index-database.comma.enable = true;
      programs.cava.enable = true;
      programs.btop.enable = true;
      programs.fastfetch.enable = true;
      programs.atuin.enable = true;
      programs.lazygit.enable = true;
      programs.bat.enable = true;

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.eza = {
        enable = true;
        icons = "always";
        colors = "always";
        enableZshIntegration = true;
      };

      programs.fzf = {
        enable = true;
        historyWidget.command = "";
        enableZshIntegration = true;
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
        };

        initContent = ''
          source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
        '';

        shellAliases = {
          cd = "z";
        };
      };
    };
  };
}
