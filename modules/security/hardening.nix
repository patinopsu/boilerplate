{
  den.aspects.hardening = {
    nixos = {
      security = {
        rtkit.enable = true;
        polkit.enable = true;
        protectKernelImage = true;
      };
    };
  };
}
