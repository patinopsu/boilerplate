{
  den.aspects.document-viewer = {
    homeManager = { pkgs, ... }: {
      programs.zathura = {
        enable = true;
        package = pkgs.zathura.override {
          plugins = [ pkgs.zathuraPkgs.zathura_pdf_mupdf ];
        };
      };

      xdg.mimeApps.defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      };
    };
  };
}
