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

          bun
        ];

        shellHook = ''
          if [ ! -d .git ]; then
              git init && git add . && echo "chore: init" > .git/COMMIT_EDITMSG
              lefthook install
          fi

          if [ ! -f package.json ]; then
            bun init -y
          fi

          if [ ! -d node_modules ] && [ -f package.json ]; then
            bun install
          fi
        '';
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
