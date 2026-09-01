{
  den.aspects.nix.nixos = {
    nix = {
      settings = {
        trusted-users = [ "root" "@wheel" ];
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
