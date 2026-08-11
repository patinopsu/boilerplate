{ inputs, den, ... }: {
  den.aspects.sudo = {
    nixos = {
      security.sudo = {
        extraConfig = ''
          Defaults pwfeedback
          Defaults passprompt="🔒password for %p: "
          Defaults badpass_message="❌Incorrect Password. Please try again."
        '';
      };
    };
  };
}
