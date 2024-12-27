{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          lefthook
          commitlint-rs
        ];

        shellHook = ''
          if [ ! -f .envrc ]; then
            echo "use flake" >> .envrc && direnv allow          
          fi

          if [ ! -d .git ]; then
            ${pkgs.git}/bin/git init && git add .
            lefthook install
          fi
        '';
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}