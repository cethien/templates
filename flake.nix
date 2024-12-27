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
          if [ ! -f .envrc ]; then
            echo "use flake" > .envrc && direnv allow
          fi
        '';
      };

      templates = {
        empty = {
          path = ./empty;
          description = "A basic project";
        };

        go = {
          path = ./go-project;
          description = "go project with some tools i usually use";
        };

        sveltekit = {
          path = ./sveltekit-project;
          description = "sveltekit project with some tools i usually use";
        };

        default = self.templates.empty;
      };
    };

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
}
