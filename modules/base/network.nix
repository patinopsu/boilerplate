{
  den.aspects.network = {
    nixos = {
      preservation.preserveAt."/persistent"= {
        directories = [
          "/var/lib/NetworkManager"
          "/etc/NetworkManager/system-connections/"
        ];
      };

      networking.networkmanager.enable = true;
      networking.firewall.enable = true;
      networking.nftables.enable = true;
    };
  };
}
