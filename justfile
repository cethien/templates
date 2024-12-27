[private]
@default:
    just --list

@create-dummy-project template="empty" dest="~/projects/dummy":
    rm -rf {{dest}}
    nix flake new -t .#{{template}} {{dest}}