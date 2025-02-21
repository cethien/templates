{
  description = "my collection of project templates, managed with nix";

  outputs = inputs @ { self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
          nixpkgs-fmt

          just
        ];

        shellHook = ''
          # for all directories called <lang>-project
          for dir in $(find . -type d -name '*-project'); do
            mkdir -p $dir/.git
            touch $dir/.git/DUMMY_GIT_REPO_FOR_DEVELOPMENT
          done
        '';
      };

      templates = {
        empty = {
          path = ./empty-project;
          description = "A basic project";
        };

        go = {
          path = ./go-project;
          description = "go project with some tools i usually use";
        };

        bun = {
          path = ./bun-project;
          description = "bun project";
        };

        default = self.templates.empty;
      };
    };

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
}
