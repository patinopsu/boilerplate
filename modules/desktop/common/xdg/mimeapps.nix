{ den, ... }: {
  den.aspects.xdg-mimeapps = {
    nixos = {
      xdg.mimeApps = {
        enable = true;

        defaultApplications = {
          # Web Browser
          "x-scheme-handler/http" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/https" = [ "zen-twilight.desktop" ];
          "x-scheme-handler/chrome" = [ "zen-twilight.desktop" ];
          "text/html" = [ "zen-twilight.desktop" ];
          "application/x-extension-htm" = [ "zen-twilight.desktop" ];
          "application/x-extension-html" = [ "zen-twilight.desktop" ];
          "application/x-extension-shtml" = [ "zen-twilight.desktop" ];
          "application/xhtml+xml" = [ "zen-twilight.desktop" ];
          "application/x-extension-xhtml" = [ "zen-twilight.desktop" ];
          "application/x-extension-xht" = [ "zen-twilight.desktop" ];

          # Image Viewer
          "image/*" = [ "org.gnome.Loupe.desktop" ];
          "image/png" = [ "org.gnome.Loupe.desktop" ];
          "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
          "image/jpg" = [ "org.gnome.Loupe.desktop" ];
          "image/webp" = [ "org.gnome.Loupe.desktop" ];
          "image/gif" = [ "org.gnome.Loupe.desktop" ];
          "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
        };
      };
    };
  };
}
