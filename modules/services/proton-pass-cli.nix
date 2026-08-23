{
  den.aspects.proton-pass-cli = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".users.${user.name} = {
        directories = [
          ".local/share/proton-pass-cli"
        ];
      };
    };
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        proton-pass-cli
      ];

      home.sessionVariables = {
        PROTON_PASS_LINUX_KEYRING = "dbus";
        SSH_AUTH_SOCK = "/home/${user.name}/.ssh/proton-pass-agent.sock";
      };

      programs.git = {
        signing = {
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILO0F9jC5uBccmMoBN71OR0zNjl8sKCYjZAEN/qKsSkN";
          signByDefault = true;
        };

        settings = {
          gpg.format = "ssh";
        };
      };

    systemd.user.services.proton-pass-agent = {
        Unit = {
          Description = "Proton Pass Agent Service";
          After = [ "network.target" ];
          StartLimitIntervalSec = "10s";
          StartLimitBurst = 5;
        };

        Service = {
          Type = "simple";
          Environment = [
            "PROTON_PASS_LINUX_KEYRING=dbus"
          ];
          ExecStart = "${pkgs.proton-pass-cli}/bin/pass-cli ssh-agent start --socket-path /home/${user.name}/.ssh/proton-pass-agent.sock --refresh-interval 20";
          Restart = "on-failure";
          RestartSec = "5s";
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
