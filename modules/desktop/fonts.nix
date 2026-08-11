{ den, ... }: {
  den.aspects.fonts = {
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
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <dir prefix="absolute">/persistent/fonts</dir>
        </fontconfig>
      '';
    };
  };
}