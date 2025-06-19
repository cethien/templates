{
  description = "my collection of project templates, managed with nix";

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
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
    })
    // {
      templates = {
        empty = {
          path = ./empty-project;
          description = "A basic project";
        };

        go = {
          path = ./go-project;
          description = "go project with some tools i usually use";
        };

        default = self.templates.empty;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
}
