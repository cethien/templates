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

          gnumake

          go_1_22
          gopls

          wgo
          goreleaser
          go-tools
        ];

        shellHook = ''
          if [ ! -f go.mod ]; then
            read -p "Module name: " MOD_NAME

            # nix templates dont support placeholders, so heres a lot of crap
			module_name=$(basename "$MOD_NAME") &&
            trimmed_module_name=$(echo "$module_name" | sed 's/[-_]//g')
			find . -type f ! -name 'flake.nix' -exec sed -i "s/go-project/$module_name/g" {} + &&
            mv cmd/go-project cmd/"$module_name" &&

			# Extract the owner and repo from the Go module path (assumed format: github.com/{owner}/{repo})
            owner=$(echo "$MOD_NAME" | awk -F/ '{print $MOD_NAME}')
            sed -i "s|ghcr.io/owner/{{ .ProjectName }}:latest|ghcr.io/$owner/{{ .ProjectName }}:latest|" .goreleaser.yml &&
            sed -i "s|ghcr.io/owner/{{ .ProjectName }}:{{ .Tag }}|ghcr.io/$owner/{{ .ProjectName }}:{{ .Tag }}|" .goreleaser.yml &&

            ${pkgs.go}/bin/go mod init $MOD_NAME &&
            ${pkgs.go}/bin/go mod tidy
          fi

          if [ ! -d .git ]; then
            ${pkgs.git}/bin/git init && git add . && echo "chore: init" > .git/COMMIT_EDITMSG
            lefthook install
          fi
        '';
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
