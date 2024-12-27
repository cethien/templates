[private]
@default:
    just --list

@create-dummy-project dest template="empty":
    nix flake new -t .#{{template}} {{dest}}