{
  den.aspects.nvidia = {
    nixos = {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = true;
        branch = "bleeding_edge";
      };
    };
  };
}
