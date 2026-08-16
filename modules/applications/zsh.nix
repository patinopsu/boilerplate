{ self, inputs, ... }:{
  den.aspects.zsh = {
    nixos = { user, ... }: {
      preservation.preserveAt."/persistent".users.${user.name} = {
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
      programs.yazi.enable = true;

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
        ];

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "eza" "zoxide" "fzf" ];
        };

        initContent = ''
          source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
          fastfetch -c ${self.outPath}/assets/fastfetch.jsonc -l ${self.outPath}/assets/nix-snowflakes.png
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        '';

        shellAliases = {
          cd = "z";
          beaufetch = "fastfetch -c ${self.outPath}/assets/fastfetch.jsonc -l ${self.outPath}/assets/nix-snowflakes.png";
        };
      };

      programs.atuin.enable = true;

      home.packages = with pkgs; [
        zoxide
        eza
        fzf
        fastfetch
        lazygit
      ];

      home.file = {
        ".p10k.zsh" = {
          source = "${self.outPath}/assets/p10k.zsh";
        };
      };
    };
  };
}
