{ den, ... }: {
  den.aspects.tailscale = { host, user, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".directories = [
        "/var/lib/tailscale"
      ];

      services.tailscale.enable = true;
      services.tailscale.extraUpFlags = [ "--ssh" "--accept-dns=true" ];
    };
  };
}
