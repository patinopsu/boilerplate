{
  den.aspects.audio = {
    nixos = { lib, pkgs, ... }: {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa.enable = true;
      };
    };
  };
}
