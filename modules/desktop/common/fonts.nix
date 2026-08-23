{ den, ... }: {
  den.aspects.fonts = { host, ... }: {
    nixos = {
      fonts.fontconfig = {
        enable = true;
        subpixel.lcdfilter = "default";
        subpixel.rgba = "rgb";
        hinting.enable = true;
        hinting.style = "slight";
      };

      fonts.fontconfig.localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <dir>/usr/share/fonts</dir>
        </fontconfig>
      '';

      fileSystems."/usr/share/fonts/nix" = {
        device = "/run/current-system/sw/share/X11/fonts";
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "x-gvfs-hide"
          "nofail"
          "resolve-symlinks"
        ];
      };

      fileSystems."/usr/share/fonts/windows" = {
        device = "${host.settings.persistPath}/fonts/Windows";
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "x-gvfs-hide"
          "nofail"
          "resolve-symlinks"
        ];
      };

      fileSystems."/usr/share/fonts/custom" = {
        device = "${host.settings.persistPath}/fonts/Custom";
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "x-gvfs-hide"
          "nofail"
          "resolve-symlinks"
        ];
      };
    };
  };
}
