{
  den.aspects.nvidia = {
    nixos = {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia-container-toolkit.enable = true;
      hardware.nvidia = {
        open = true;
        branch = "bleeding_edge";
      };
    };
  };
}
