{
  den.aspects.virtualization = {
    nixos = { lib, pkgs, ... }: {
      preservation.preserveAt."/persistent".directories = [
        "/var/lib/libvirt"
      ];

      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
      environment.systemPackages = [
        pkgs.swtpm
      ];
    };
  };
}
