[private]
@default:
    just --list

alias fmt := format
@format:
    nixpkgs-fmt .

alias l := lint
@lint:
    nixpkgs-fmt --check .

@create-dummy-project template="empty" dest="~/projects/dummy":
    rm -rf {{dest}}
    nix flake new -t .#{{template}} {{dest}}