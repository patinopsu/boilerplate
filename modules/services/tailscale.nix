{ den, ... }: {
  den.aspects.docker = { user, ... }: {
    nixos = {
      preservation.preserveAt."/persistent".directories = [
        "/var/lib/tailscale"
      ];

      services.tailscale.enable = true;
      services.tailscale.extraUpFlags = [ "--ssh" "--accept-dns=true" ];
    };
  };
}
