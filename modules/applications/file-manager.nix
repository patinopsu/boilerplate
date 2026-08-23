{
  den.aspects.file-manager = {
    homeManager = { pkgs, ... }: {
      programs.yazi = {
        enable = true;
      };

      xdg.mimeApps.defaultApplications = {
        "inode/directory" = [ "yazi.desktop" ];
      };
    };
  };
}
