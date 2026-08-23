{
  den.aspects.audio = {
    nixos = {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa.enable = true;
      };
    };
  };
}
