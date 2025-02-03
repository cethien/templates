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

          just
          wgo

          pandoc
          wkhtmltopdf
          bun
        ];

        shellHook = ''
          if [ ! -d .git ]; then
            git init && git add . && echo "chore: init" > .git/COMMIT_EDITMSG   
          fi

          if [ -f lefthook.yaml ]; then
            lefthook install
          fi

          if [ -f package.json ] && [ ! -d node_modules ]; then
            bun install
          fi
        '';
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
