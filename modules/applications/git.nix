{ den, ... }: {
  den.aspects.git = {
    homeManager = {
      programs.git.enable = true;
      programs.git.settings = {
	      user.name = "Patin Muangjan";
	      user.email = "patin@patin.dev";
      };
    };
  };
}
