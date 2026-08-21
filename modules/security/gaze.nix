{ inputs, den, ... }: {
  den.aspects.gaze = { host, ... }: {
    nixos = {
      imports = [
        inputs.gaze.nixosModules.default
      ];

      preservation.preserveAt."${host.settings.persistPath}" = {
        directories = [
          "/var/lib/gaze"
          "/var/cache/gaze"
        ];
      };

      services.gaze = {
        enable = true;
        gui.enable = true;
        mutableConfig = false;
        settings = {
          auth = {
            abort_if_lid_closed = false;
            abort_if_ssh = true;
            require_confirmation_elevation = false;
            require_confirmation_lock_screen = false;
            resume_grace_ms = 0;
            start_delay_ms = 0;
            start_delay_scope = "screen_lock";
          };

          enrollment = {
            max_templates = 2;
            min_face_size_ratio = 0.25;
          };

          inference = {
            device = "cpu";
            execution_provider = "cpu";
          };

          liveness = {
            enabled = true;
            max_frames = 40;
            threshold = 0.8;
          };

          security = {
            level = "medium";
          };

          storage = {
            encrypt_templates = true;
          };
        };
      };
      security.pam.services.login.gaze.enable = true;
    };
  };
}
