{
  den.aspects.tailscale = { host, ... }: {
    nixos = {
      preservation.preserveAt."${host.settings.persistPath}".directories = [
        "/var/lib/tailscale"
      ];

      services.tailscale.enable = true;
      services.tailscale.extraUpFlags = [ "--ssh" "--accept-dns=true" ];
    };
  };
}
