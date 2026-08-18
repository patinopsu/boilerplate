{ inputs, den, ... }: {
  den.aspects.network = {
    nixos = { user, ... }: {
      preservation.preserveAt."/persistent"= {
        directories = [
          "/var/lib/NetworkManager"
          "/etc/NetworkManager/system-connections/"
        ];
      };

      networking.networkmanager.enable = true;
    };
  };
}
