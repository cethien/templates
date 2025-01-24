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

          go
          wgo
          gopls
		  delve
          go-tools

		  goose

          goreleaser
        ];

        shellHook = ''
          if [ ! -f go.mod ]; then
            MOD_NAME=github.com/$USER/$(basename "$PWD")

            # nix templates dont support placeholders, so heres a lot of crap
			find . -type f ! -name 'flake.nix' -exec sed -i "s|example.com/go-project|$MOD_NAME|g" {} + &&
			module_name=$(basename "$MOD_NAME") &&
            trimmed_module_name=$(echo "$module_name" | sed 's/[-_]//g')
			find . -type f ! -name 'flake.nix' -exec sed -i "s/go-project/$module_name/g" {} + &&
            mv cmd/go-project cmd/"$module_name" &&

			# Extract the owner and repo from the Go module path (assumed format: github.com/{owner}/{repo})
            owner=$(echo "$MOD_NAME" | awk -F/ '{print $2}')
            sed -i "s|ghcr.io/owner/{{ .ProjectName }}:latest|ghcr.io/$owner/{{ .ProjectName }}:latest|" .goreleaser.yml &&
            sed -i "s|ghcr.io/owner/{{ .ProjectName }}:{{ .Tag }}|ghcr.io/$owner/{{ .ProjectName }}:{{ .Tag }}|" .goreleaser.yml &&

            go mod init $MOD_NAME &&
            go mod tidy
          fi

          if [ ! -d .git ]; then
            git init && git add . && echo "chore: init" > .git/COMMIT_EDITMSG
            lefthook install
          fi

		  if [ ! -f .env ] && [ -f .env.template ]; then
		    cp .env.template .env
		  fi
        '';
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };
}
