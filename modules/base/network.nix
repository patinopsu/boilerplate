{ self, ... }: {
  den.aspects.network = { host, ... }: {
    nixos = { config, ... }: {
      preservation.preserveAt."/persistent"= {
        directories = [
          "/var/lib/NetworkManager"
          "/etc/NetworkManager/system-connections/"
        ];
      };

      networking = {
        networkmanager = {
          enable = true;
          dns = "none";
          appendNameservers = [
            "127.0.0.53"
          ];
        };

        firewall.enable = true;
        nftables.enable = true;
      };

      sops = {
        secrets."nextdns-id" = {
          sopsFile = "${self.outPath}/secrets/nextdns-id.yaml";
          key = "id";
        };

        templates."dnsproxy.yaml" = {
          group = "keys";
          mode = "0440";
          path = "/run/dnsproxy.yaml";
          content = ''
            listen-addrs:
              - 127.0.0.53
            listen-ports:
              - 53
            upstream:
              - https://dns.nextdns.io/${config.sops.placeholder.nextdns-id}/${host.settings.prettyName}
            bootstrap:
              - 1.1.1.1
              - 9.9.9.9
          '';
        };
      };

      services.dnsproxy = {
          enable = true;
          flags = [ "--config-path=${config.sops.templates."dnsproxy.yaml".path}" ];
      };
      services.resolved.enable = false;

      systemd.services.dnsproxy.serviceConfig = {
        SupplementaryGroups = [ "keys" ];
        BindReadOnlyPaths = [
          "/run/secrets/rendered"
          "${config.sops.templates."dnsproxy.yaml".path}"
        ];
      };
    };
  };
}
