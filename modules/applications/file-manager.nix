{
  den.aspects.file-manager = {
    homeManager = {
      programs.yazi = {
        enable = true;
      };

      xdg.mimeApps.defaultApplications = {
        "inode/directory" = [ "yazi.desktop" ];
      };
    };
  };
}
