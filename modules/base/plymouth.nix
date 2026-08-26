{
  den.aspects.plymouth = {
    boot = {
      plymouth = {
        enable = true;
      };

      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];
    };
    stylix.targets.plymouth.enable = false;
  };
}
