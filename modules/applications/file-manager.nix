{
  den.aspects.file-manager = {
    homeManager = { pkgs, ... }: {
      programs.yazi = {
        enable = true;
      };

      xdg.mime.defaultApplications = {
        "inode/directory" = [ "yazi.desktop" ];
      };
    };
  };
}
