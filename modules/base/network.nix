{ inputs, den, ... }: {
  den.aspects.network = {
    nixos = { user, ... }: {
      preservation.preserveAt."/persistent"= {
        directories = [
          "/var/lib/NetworkManager"
        ];
      };

      networking.networkmanager = {
        enable = true;
      };
    };
  };
}
