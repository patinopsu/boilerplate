{ inputs, den, ... }: {
  den.hosts.x86_64-linux.t14gen1 = {
    users.patin = {};
  };

  den.aspects.t14gen1 = {
    includes = [
      # --- Core --- #
      den.aspects.boot
      den.aspects.preservation
      den.aspects.network
      den.aspects.nix
      den.aspects.niri

      # --- Hardware Driver --- #
      den.aspects.intelgpu

      # --- Security --- #
      den.aspects.hardening
      den.aspects.sudo

      # --- Services --- #
      den.aspects.tailscale

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
      den.aspects.mpv
      den.aspects.vicinae
    ];

    nixos = { config, lib, pkgs, user, ... }: {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      boot.kernelParams = [ "i915.enable_guc=3" "i915.enable_psr=0" "i915.enable_fbc=1" ];

      services.tuned.enable = true;
      services.power-profiles-daemon.enable = false;

      boot.initrd.availableKernelModules = [ "tpm_tis" "xhci_pci" "nvme" "usbhid" "usb_storage" "rtsx_pci_sdmmc" "sd_mod" ];
      boot.initrd.kernelModules = [ "dm-snapshot" ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      users.users.${user.name} = {
        initialPassword = lib.mkForce null;
        hashedPassword = lib.mkForce "$y$j9T$mehwnm0lpqvh.8WtIMkhw1$m4NYRPfsbuK.HGGk0Q7dwA9OGnbrHYWOZbFvE3mJxu2";
      };

      hardware.enableAllFirmware = true;
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      time.timeZone = "Asia/Bangkok";
      networking.hostName = "cygnus";

      disko.devices.disk.main.device = "/dev/nvme0n1";
      disko.devices.disk.main.type = "disk";
      disko.devices.disk.main.content.type = "gpt";

      disko.devices.disk.main.content.partitions.esp = {
        priority = 1;
        name = "ESP";
        size = "4G";
        type = "EF00";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = [ "umask=0077" ];
        };
      };

      disko.devices.disk.main.content.partitions.luks = {
        size = "100%";
        content = {
          type = "luks";
          name = "crypted";
          extraFormatArgs = [ "--sector-size" "4096" ];
          extraOpenArgs = [
            "--allow-discards"
            "--perf-no_read_workqueue"
            "--perf-no_write_workqueue"
          ];
          settings = {
            allowDiscards = true;
            bypassWorkqueues = true;
          };
          content = {
            type = "lvm_pv";
            vg = "pool";
          };
        };
      };

      disko.devices.lvm_vg.pool.type = "lvm_vg";

      disko.devices.lvm_vg.pool.lvs.sys = {
        size = "160G";
        content = {
          type = "btrfs";
          extraArgs = [ "-f -L NixOS" ];
          subvolumes = {
            "/@root" = {
              mountpoint = "/";
              mountOptions = [ "compress=zstd:1" "noatime" ];
            };
            "/@nix" = {
              mountpoint = "/nix";
              mountOptions = [ "compress=zstd:1" "noatime" ];
            };
            "/@persist" = {
              mountpoint = "/persistent";
              mountOptions = [ "compress=zstd:1" "noatime" ];
            };
            "/@swap" = {
              mountpoint = "/swap";
              mountOptions = [ "noatime" ];
            };
          };
        };
      };

      disko.devices.lvm_vg.pool.lvs.data = {
        size = "100%FREE";
        content = {
          type = "btrfs";
          extraArgs = [ "-f" ];
          subvolumes = {
            "/@data" = {
              mountpoint = "/mnt/d";
              mountOptions = [ "compress=zstd:1" "noatime" ];
            };
          };
        };
      };

      boot.initrd.systemd.services.recreate-root = {
        description = "Rolling over and creating new filesystem root";

        wantedBy = [ "initrd.target" ];
        requires = [ "initrd-root-device.target" ];
        after = [
          "initrd-root-device.target"
          "local-fs-pre.target"
        ];
        before = [
          "sysroot.mount"
          "create-needed-for-boot-dirs.service"
        ];

        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";

        script = /* sh */ ''
          mkdir -p /btrfs_tmp
          mount /dev/pool/sys /btrfs_tmp

          # Check if @root exists and archive it with a timestamp
          if [[ -e /btrfs_tmp/@root ]]; then
            mkdir -p /btrfs_tmp/@old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@root)" "+%Y-%m-%d_%H:%M:%S")
            mv /btrfs_tmp/@root "/btrfs_tmp/@old_roots/$timestamp"
          fi

          # Helper function to delete nested btrfs subvolumes
          delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
          }

          # Delete archived roots older than 30 days
          if [[ -d /btrfs_tmp/@old_roots ]]; then
            for i in $(find /btrfs_tmp/@old_roots/ -maxdepth 1 -mindepth 1 -mtime +30); do
              delete_subvolume_recursively "$i"
            done
          fi

          # Create fresh @root
          btrfs subvolume create /btrfs_tmp/@root
          umount /btrfs_tmp
        '';
      };
    };
    homeManager = {
      programs.niri.settings = {
      input = {
        mouse = {
          accel-speed = -0.30;
        };
      };

      outputs = {
        "eDP-1" = {
          enable = true;
          scale = 1;
          mode = {
            width = 1920;
            height = 1080;
          };
        };
      };
    };
  };
  };
}