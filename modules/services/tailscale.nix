{
  den.aspects.tailscale = { host, ... }: {
    nixos = { config, ... }: {
      preservation.preserveAt."${host.settings.persistPath}".directories = [
        "/var/lib/tailscale"
      ];

      networking.search = [ "cymric-reedfish.ts.net" ];
      networking.networkmanager = {
        unmanaged = [
          "tailscale0"
        ];
        appendNameservers = [
          "100.100.100.100"
        ];
      };

      networking.firewall = {
        trustedInterfaces = [ "tailscale0" ];
        allowedUDPPorts = [ config.services.tailscale.port ];
      };

      services.tailscale = {
        enable = true;
        extraUpFlags = [ "--ssh" "--accept-dns=false" ];
      };
    };
  };
}
