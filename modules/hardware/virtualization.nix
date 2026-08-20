{
  den.aspects.virtualization = { user, ... }: {
    nixos = { lib, pkgs, ... }: {
      preservation.preserveAt."/persistent".directories = [
        "/var/lib/libvirt"
      ];

      virtualisation.libvirtd.enable = true;
      virtualisation.libvirtd.qemu.swtpm.enable = true;
      networking.firewall.trustedInterfaces = [ "virbr0" ];
      programs.virt-manager.enable = true;

      environment.systemPackages = with pkgs; [ 
        dnsmasq 
      ];

      users.users.${user.name}.extraGroups = [ "libvirtd" "kvm" ];
    };
  };
}
