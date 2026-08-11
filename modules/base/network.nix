{ inputs, den, ... }: {
  den.aspects.network = {
    nixos = {
      networking.networkmanager = {
        enable = true;
      };
    };
  };
}
