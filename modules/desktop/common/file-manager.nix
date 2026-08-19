{
  den.aspects.file-manager = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        kdePackages.kio
        kdePackages.kio-fuse
        kdePackages.kio-extras

        kdePackages.qtsvg

        kdePackages.ark
        kdePackages.dolphin
      ];

      environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
    };
  };
}