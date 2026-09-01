{ inputs, den, ... }: {
  den.hosts.x86_64-linux.t14gen1 = {
    users.patin = {};
    settings = {
      prettyName = "ThinkPad T14 Gen 1";
      persistPath = "/persistent";
    };
  };

  den.aspects.t14gen1 = { host, ... }: {
    includes = [
      # --- Core --- #
      den.aspects.boot
      den.aspects.preservation
      den.aspects.network
      den.aspects.nix
      den.aspects.niri
      den.aspects.virtualization
      den.aspects.plymouth

      # --- Hardware Driver --- #
      den.aspects.audio
      den.aspects.bluetooth
      den.aspects.intelgpu
      den.aspects.android
      den.aspects.drawing-tablet

      # --- Security --- #
      den.aspects.hardening
      den.aspects.sudo
      den.aspects.secureboot
      den.aspects.gaze
      den.aspects.secrets

      # --- Services --- #
      den.aspects.tailscale
      den.aspects.docker
      den.aspects.captiveportal

      # --- CLI / Programs --- #
      den.aspects.git
      den.aspects.flatpak
      den.aspects.browsers
      den.aspects.zsh
      den.aspects.distrobox
      den.aspects.vscode
      den.aspects.proton-pass-cli
      den.aspects.syncthing
      den.aspects.spotify
    ];

    nixos = { config, lib, pkgs, user, ... }: {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen1
      ];

      boot.kernelParams = [ "psmouse.proto=imps" ];

      services.upower.enable = true;
      services.tlp.settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
        DISK_APM_LEVEL_ON_BAT = "254 254";
        PLATFORM_PROFILE_ON_BAT= "balanced";
        INTEL_GPU_POWER_PROFILE_ON_BAT= "balance";
        SOUND_POWER_SAVE_ON_AC = 0;
        SOUND_POWER_SAVE_ON_BAT = 0;
        SOUND_POWER_SAVE_CONTROLLER = "N";
      };

      hardware.graphics.extraPackages = lib.mkForce (with pkgs; [
        vpl-gpu-rt
        intel-media-driver
        intel-compute-runtime
      ]);

      services.gaze.settings.cameras = {
        dark_luma_threshold = 20;
        rgb = "usb:04f2:b6d0";
        emitter_enabled = true;
        ir = "usb:04f2:b6d0";
      };

      boot.initrd.availableKernelModules = [ "tpm_tis" "xhci_pci" "nvme" "usbhid" "usb_storage" "rtsx_pci_sdmmc" "sd_mod" ];
      boot.initrd.kernelModules = [ "dm-snapshot" ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      users.users.${user.name} = {
        initialPassword = null;
        hashedPassword = "$y$j9T$mehwnm0lpqvh.8WtIMkhw1$m4NYRPfsbuK.HGGk0Q7dwA9OGnbrHYWOZbFvE3mJxu2";
        extraGroups = [ "dialout" ];
      };

      hardware.enableAllFirmware = true;
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      time.timeZone = "Asia/Bangkok";
      networking.hostName = "cygnus";
      programs.captive-browser.interface = "wlp0s20f3";

      boot.lanzaboote.configurationLimit = 8;
      boot.lanzaboote.measuredBoot = {
        enable = true;
        pcrs = [ 0 7 ];
      };

      swapDevices = [
        {
          device = "/swap/swapfile";
        }
      ];

      services.udev.extraRules = ''
        ACTION=="add|change", KERNEL=="event[0-9]*", ENV{ID_PATH}=="platform-i8042-serio-1", ENV{ID_INPUT_POINTINGSTICK}="1"
      '';

      services.throttled.enable = true;

      fileSystems."/nix".neededForBoot = true;
      fileSystems."${host.settings.persistPath}".neededForBoot = true;

      disko.devices.disk.main.device = "/dev/disk/by-id/nvme-KINGBANK_KP230_CP153BB2304897";
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

        script = ''
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

          # Delete archived roots older than 7 days
          if [[ -d /btrfs_tmp/@old_roots ]]; then
            for i in $(find /btrfs_tmp/@old_roots/ -maxdepth 1 -mindepth 1 -mtime +7); do
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
      xdg.userDirs = {
        enable = true;
        documents = "/mnt/d/Documents";
        download = "/mnt/d/Downloads";
        projects = "/mnt/d/Projects";
        pictures = "/mnt/d/Pictures";
        videos = "/mnt/d/Videos";
        music = "/mnt/d/Music";
      };

      wayland.windowManager.niri = {
        settings = {
          input.trackpoint = {
            accel-speed = 0.25;
            accel-profile = "adaptive";
          };

          binds = {
            "XF86Display" = {
              _props.hotkey-overlay-title = "Duplicate Internal Display to External Display";
              spawn = [ "noctalia" "msg" "panel-toggle" "elijaharch/wl-screen-mirror:controls" ];
            };

            "XF86NotificationCenter" = {
              _props.hotkey-overlay-title = "Open Display Configuration";
              spawn = [ "noctalia" "msg" "panel-toggle" "raycursive/niri-displays:panel" ];
            };
          };

          _children = [
            {
              output = {
                _args = [ "eDP-1" ];
                mode._args = [ "1920x1080@60.000" ];
                scale = 1.2;
              };
            }
          ];
        };
      };

      programs.noctalia.settings = {
        wallpaper.path = "/mnt/d/Pictures/Wallpapers";
      };
    };
  };
}
