{ inputs, den, ... }: {

  den.hosts.x86_64-linux.workstation = {
    users.patin = {};
  };

  den.aspects.workstation = {
    includes = [
      # --- Core --- #
      den.aspects.boot
      den.aspects.preservation
      den.aspects.network
      den.aspects.nix
      den.aspects.desktop-plasma

      # --- Hardware Driver --- #
      den.aspects.intelgpu
      den.aspects.nvidia

      # --- Security --- #
      den.aspects.hardening
      den.aspects.sudo

      # --- Services --- #
      den.aspects.docker

      # --- User --- #
      den.aspects.patin

      # --- CLI / Programs --- #
      den.aspects.git
      den.aspects.flatpak
      den.aspects.browsers
      den.aspects.zsh
      den.aspects.kitty
      den.aspects.vscode
      den.aspects.proton-pass-cli
    ];

    nixos = { config, lib, pkgs, ... }: {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      time.timeZone = "Asia/Bangkok";
      networking.hostName = "orion"; 

      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      fileSystems."/mnt/d" = {
        device = "/dev/disk/by-id/ata-CT500BX500SSD1_2442E98FEBF5";
        fsType = "btrfs";
        options = [
          "nofail"
          "compress=zstd:1"
          "ssd"
          "noatime"
          "discard=async"
          "space_cache=v2"
        ];
      };

      fileSystems."/nix".neededForBoot = true;
      fileSystems."/persistent".neededForBoot = true;

      disko.devices.nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            "size=25%"
            "mode=755"
          ];
        };
      };

      disko.devices.disk.main = {
        device = "/dev/disk/by-id/nvme-HS-SSD-E3000_256G_30129830267";
        type = "disk";
        content.type = "gpt";

        content.partitions.esp = {
          name = "ESP";
          size = "4G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };

        content.partitions.root = {
          name = "root";
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-f -L NixOS"];

            subvolumes = {
              #"/@home" = {
              #  mountOptions = [
              #    "subvol=@home"
              #    "compress=zstd:1"
              #    "ssd"
              #    "noatime"
              #    "discard=async"
              #    "space_cache=v2"
              #  ];
              #  mountpoint = "/home";
              #};

              "/@persistent" = {
                mountOptions = [
                  "subvol=@persistent"
                  "compress=zstd:1"
                  "ssd"
                  "noatime"
                  "discard=async"
                  "space_cache=v2"
                ];
                mountpoint = "/persistent";
              };

              "/@nix" = {
                mountOptions = [
                  "subvol=@nix"
                  "compress=zstd:1"
                  "ssd"
                  "noatime"
                  "discard=async"
                  "space_cache=v2"
                ];
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
  };
}
