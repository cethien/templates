{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          lefthook
          commitlint-rs

          go
          gopls
          go-tools
	        delve

		      just
          wgo

          goreleaser
        ];

        shellHook = ''
          if [ ! -d .git ]; then
            git init && git add . && echo "chore: init" > .git/COMMIT_EDITMSG   
          fi

          if [ -f lefthook.yaml ]; then
            lefthook install
          fi

          if [ ! -f .goreleaser.yaml ]; then
            goreleaser init
          fi

          if [ -f go.mod ]; then
            go mod tidy
          fi
        '';
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };
}
