{
  den.aspects.heroic = {
    nixos = {
      services.flatpak.packages = [
        { appId = "com.heroicgameslauncher.hgl"; origin = "flathub"; }
      ];
    };
  };
}
