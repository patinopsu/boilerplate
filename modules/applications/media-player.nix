{ ... }: {
  den.aspects.mpv = {
    homeManager = { pkgs, ... }: {
      programs.mpv = {
        enable = true;
        config = {
          profile = "high-quality";
          vo = "gpu-next";
          gpu-api = "auto";

          hwdec = "auto-safe";

          scale = "ewa_lanczossharp";
          dscale = "mitchell";
          cscale = "spline36";

          dither-depth = "auto";
          deband = true;

          video-sync = "display-resample";
          interpolation = true;
          tscale = "oversample";
        };
      };

      xdg.mimeApps.defaultApplications = {
        "video/mp4" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/x-msvideo" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "video/mpeg" = [ "mpv.desktop" ];
      };
    };
  };
}
